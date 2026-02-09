import Foundation

public final class ChatListViewModel {
    public var onThreadsChanged: (([ChatThread]) -> Void)?
    private(set) var threads: [ChatThread] = []

    public init() {}

    public func start() {
        let now = Date()
        threads = [
            ChatThread(id: "1", title: "Saved Messages", subtitle: "Pinned notes and links", lastMessageAt: now.addingTimeInterval(-60), unreadCount: 0, isPinned: true),
            ChatThread(id: "2", title: "Boss", subtitle: "Let create chat list screen", lastMessageAt: now.addingTimeInterval(-120), unreadCount: 2),
            ChatThread(id: "3", title: "iOS Team", subtitle: "Build passed on CI ✅", lastMessageAt: now.addingTimeInterval(-1200), unreadCount: 14, isMuted: true),
            ChatThread(id: "4", title: "Design", subtitle: "New icon set exported", lastMessageAt: now.addingTimeInterval(-4200), unreadCount: 0)
        ].sorted { lhs, rhs in
            if lhs.isPinned != rhs.isPinned { return lhs.isPinned && !rhs.isPinned }
            return lhs.lastMessageAt > rhs.lastMessageAt
        }
        onThreadsChanged?(threads)
    }

    public func thread(at index: Int) -> ChatThread? {
        guard threads.indices.contains(index) else { return nil }
        return threads[index]
    }
}
