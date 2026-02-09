import AsyncDisplayKit
import UIKit

public final class MessageTextCellNode: ASCellNode {
    private let bubbleNode = ASDisplayNode()
    private let textNode = ASTextNode()
    private let message: ChatMessage
    private let theme: ChatTheme

    public init(message: ChatMessage, theme: ChatTheme) {
        self.message = message
        self.theme = theme
        super.init()

        automaticallyManagesSubnodes = true
        selectionStyle = .none

        bubbleNode.cornerRadius = 18
        bubbleNode.backgroundColor = message.isOutgoing ? theme.outgoingBubbleColor : theme.incomingBubbleColor

        textNode.maximumNumberOfLines = 0
        textNode.attributedText = NSAttributedString(
            string: message.text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: message.isOutgoing ? theme.outgoingTextColor : theme.incomingTextColor
            ]
        )
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        textNode.style.maxWidth = ASDimension(unit: .fraction, value: 0.72)

        let contentInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12),
            child: textNode
        )
        let bubble = ASBackgroundLayoutSpec(child: contentInsets, background: bubbleNode)

        let row = ASStackLayoutSpec.horizontal()
        row.justifyContent = message.isOutgoing ? .end : .start
        row.children = [bubble]

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8), child: row)
    }
}
