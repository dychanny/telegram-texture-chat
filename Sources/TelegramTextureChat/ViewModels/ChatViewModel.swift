import Foundation

public final class ChatViewModel {
    public var onMessagesChanged: (([ChatMessage]) -> Void)?

    private let me: ChatUser
    private let store: MessageStore
    private let socket: ChatSocketService

    public init(me: ChatUser, store: MessageStore, socket: ChatSocketService) {
        self.me = me
        self.store = store
        self.socket = socket
        self.socket.onEvent = { [weak self] event in
            self?.handle(event)
        }
    }

    public func start() {
        socket.connect()
        onMessagesChanged?(store.all())
    }

    public func stop() {
        socket.disconnect()
    }

    public func send(text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        var msg = ChatMessage(sender: me, text: trimmed, isOutgoing: true, state: .sending)
        store.upsert(msg)
        onMessagesChanged?(store.all())

        socket.send(msg)

        msg.state = .sent
        store.upsert(msg)
        onMessagesChanged?(store.all())
    }

    private func handle(_ event: ChatSocketEvent) {
        switch event {
        case .message(let message):
            store.upsert(message)
        case .ack(let localId, let serverId):
            if var m = store.all().first(where: { $0.localId == localId }) {
                m.serverId = serverId
                m.state = .delivered
                store.upsert(m)
            }
        case .read(let serverIds):
            var current = store.all()
            for i in current.indices where current[i].serverId.map(serverIds.contains) == true {
                current[i].state = .read
                store.upsert(current[i])
            }
        case .connected, .disconnected, .error:
            break
        }

        onMessagesChanged?(store.all())
    }
}
