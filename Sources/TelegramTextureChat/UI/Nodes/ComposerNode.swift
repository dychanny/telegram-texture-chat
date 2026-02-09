import AsyncDisplayKit
import UIKit

public final class ComposerNode: ASDisplayNode {
    public var onSend: ((String) -> Void)?

    private let textNode = ASEditableTextNode()
    private let sendButton = ASButtonNode()
    private let backgroundNode = ASDisplayNode()

    public override init() {
        super.init()
        automaticallyManagesSubnodes = true

        backgroundNode.backgroundColor = .secondarySystemBackground
        backgroundNode.cornerRadius = 20

        textNode.attributedPlaceholderText = NSAttributedString(
            string: "Message",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        textNode.typingAttributes = [
            NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor.rawValue: UIColor.label
        ]
        textNode.style.flexGrow = 1

        sendButton.setTitle("Send", with: .boldSystemFont(ofSize: 15), with: .systemBlue, for: .normal)
        sendButton.addTarget(self, action: #selector(sendTapped), forControlEvents: .touchUpInside)
    }

    @objc private func sendTapped() {
        let text = textNode.attributedText?.string ?? ""
        onSend?(text)
        textNode.attributedText = NSAttributedString(string: "")
        setNeedsLayout()
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        sendButton.style.spacingBefore = 8

        let row = ASStackLayoutSpec.horizontal()
        row.alignItems = .center
        row.children = [textNode, sendButton]

        let padded = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12), child: row)
        let bg = ASBackgroundLayoutSpec(child: padded, background: backgroundNode)

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: bg)
    }
}
