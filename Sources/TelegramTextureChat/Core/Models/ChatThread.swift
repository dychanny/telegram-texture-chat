import Foundation

public struct ChatThread: Equatable, Hashable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let lastMessageAt: Date
    public let unreadCount: Int
    public let isPinned: Bool
    public let isMuted: Bool

    public init(
        id: String,
        title: String,
        subtitle: String,
        lastMessageAt: Date,
        unreadCount: Int = 0,
        isPinned: Bool = false,
        isMuted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.lastMessageAt = lastMessageAt
        self.unreadCount = unreadCount
        self.isPinned = isPinned
        self.isMuted = isMuted
    }
}
