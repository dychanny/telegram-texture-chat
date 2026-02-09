import AsyncDisplayKit
import UIKit

public final class ChatThreadCellNode: ASCellNode {
    private let avatarNode = ASDisplayNode()
    private let titleNode = ASTextNode()
    private let subtitleNode = ASTextNode()
    private let timeNode = ASTextNode()
    private let unreadNode = ASTextNode()

    private let thread: ChatThread

    public init(thread: ChatThread) {
        self.thread = thread
        super.init()
        automaticallyManagesSubnodes = true
        selectionStyle = .none

        avatarNode.style.preferredSize = CGSize(width: 52, height: 52)
        avatarNode.cornerRadius = 26
        avatarNode.backgroundColor = thread.isPinned ? UIColor.systemBlue : UIColor.systemGray4

        titleNode.attributedText = NSAttributedString(
            string: thread.title,
            attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .semibold), .foregroundColor: UIColor.label]
        )

        let subtitleText = thread.isMuted ? "🔕 \(thread.subtitle)" : thread.subtitle
        subtitleNode.attributedText = NSAttributedString(
            string: subtitleText,
            attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.secondaryLabel]
        )
        subtitleNode.maximumNumberOfLines = 1
        subtitleNode.truncationMode = .byTruncatingTail

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        timeNode.attributedText = NSAttributedString(
            string: formatter.localizedString(for: thread.lastMessageAt, relativeTo: Date()),
            attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.secondaryLabel]
        )

        unreadNode.attributedText = NSAttributedString(
            string: thread.unreadCount > 99 ? "99+" : "\(thread.unreadCount)",
            attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        )
        unreadNode.backgroundColor = .systemBlue
        unreadNode.cornerRadius = 10
        unreadNode.clipsToBounds = true
        unreadNode.textContainerInset = UIEdgeInsets(top: 2, left: 7, bottom: 2, right: 7)
        unreadNode.isHidden = thread.unreadCount == 0
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let titleTimeRow = ASStackLayoutSpec.horizontal()
        titleTimeRow.justifyContent = .spaceBetween
        titleTimeRow.alignItems = .start
        titleNode.style.flexGrow = 1
        titleNode.style.flexShrink = 1
        titleTimeRow.children = [titleNode, timeNode]

        let subtitleRow = ASStackLayoutSpec.horizontal()
        subtitleRow.justifyContent = .spaceBetween
        subtitleRow.alignItems = .center
        subtitleNode.style.flexGrow = 1
        subtitleNode.style.flexShrink = 1
        subtitleRow.children = [subtitleNode, unreadNode]

        let contentCol = ASStackLayoutSpec.vertical()
        contentCol.spacing = 4
        contentCol.style.flexGrow = 1
        contentCol.style.flexShrink = 1
        contentCol.children = [titleTimeRow, subtitleRow]

        let row = ASStackLayoutSpec.horizontal()
        row.alignItems = .center
        row.spacing = 12
        row.children = [avatarNode, contentCol]

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14), child: row)
    }
}
