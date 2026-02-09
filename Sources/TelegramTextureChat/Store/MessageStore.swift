import Foundation

public final class MessageStore {
    private var messages: [ChatMessage] = []
    private let queue = DispatchQueue(label: "chat.message.store", qos: .userInitiated)

    public init() {}

    public func all() -> [ChatMessage] {
        queue.sync { messages.sorted(by: { $0.createdAt < $1.createdAt }) }
    }

    public func upsert(_ message: ChatMessage) {
        queue.sync {
            if let idx = messages.firstIndex(where: { $0.localId == message.localId || ($0.serverId != nil && $0.serverId == message.serverId) }) {
                messages[idx] = message
            } else {
                messages.append(message)
            }
        }
    }

    public func prepend(_ older: [ChatMessage]) {
        queue.sync { messages.append(contentsOf: older) }
    }
}
