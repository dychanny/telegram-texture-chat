import Foundation

public enum MessageDeliveryState: Equatable, Hashable {
    case sending
    case sent
    case delivered
    case read
    case failed(reason: String?)
}

public struct ChatUser: Equatable, Hashable {
    public let id: String
    public let displayName: String

    public init(id: String, displayName: String) {
        self.id = id
        self.displayName = displayName
    }
}

public struct ChatMessage: Equatable, Hashable {
    public let localId: String
    public var serverId: String?
    public let sender: ChatUser
    public let text: String
    public let createdAt: Date
    public var isOutgoing: Bool
    public var state: MessageDeliveryState

    public init(
        localId: String = UUID().uuidString,
        serverId: String? = nil,
        sender: ChatUser,
        text: String,
        createdAt: Date = Date(),
        isOutgoing: Bool,
        state: MessageDeliveryState = .sending
    ) {
        self.localId = localId
        self.serverId = serverId
        self.sender = sender
        self.text = text
        self.createdAt = createdAt
        self.isOutgoing = isOutgoing
        self.state = state
    }
}
