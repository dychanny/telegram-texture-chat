import Foundation

public enum ChatSocketEvent {
    case connected
    case disconnected
    case message(ChatMessage)
    case ack(localId: String, serverId: String)
    case read(serverIds: [String])
    case error(String)
}

public protocol ChatSocketService: AnyObject {
    var onEvent: ((ChatSocketEvent) -> Void)? { get set }
    func connect()
    func disconnect()
    func send(_ message: ChatMessage)
}
