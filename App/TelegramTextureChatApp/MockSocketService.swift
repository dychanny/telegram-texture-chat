import Foundation

final class MockSocketService: ChatSocketService {
    var onEvent: ((ChatSocketEvent) -> Void)?
    private let me: ChatUser

    init(me: ChatUser) {
        self.me = me
    }

    func connect() {
        onEvent?(.connected)

        // Seed a couple of demo messages.
        let other = ChatUser(id: "friend", displayName: "Friend")
        onEvent?(.message(ChatMessage(sender: other, text: "Yo 👋", isOutgoing: false, state: .read)))
        onEvent?(.message(ChatMessage(sender: other, text: "Texture feels smooth.", isOutgoing: false, state: .read)))
    }

    func disconnect() {
        onEvent?(.disconnected)
    }

    func send(_ message: ChatMessage) {
        // Fake ack after a short delay.
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.35) { [weak self] in
            self?.onEvent?(.ack(localId: message.localId, serverId: UUID().uuidString))
        }

        // Fake echo reply.
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self else { return }
            let other = ChatUser(id: "friend", displayName: "Friend")
            let reply = ChatMessage(sender: other, text: "Echo: \(message.text)", isOutgoing: false, state: .delivered)
            self.onEvent?(.message(reply))
        }
    }
}
