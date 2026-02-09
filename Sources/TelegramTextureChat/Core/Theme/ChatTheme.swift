import UIKit

public struct ChatTheme {
    public var backgroundColor: UIColor
    public var incomingBubbleColor: UIColor
    public var outgoingBubbleColor: UIColor
    public var incomingTextColor: UIColor
    public var outgoingTextColor: UIColor
    public var composerBackground: UIColor
    public var composerTextColor: UIColor

    public init(
        backgroundColor: UIColor,
        incomingBubbleColor: UIColor,
        outgoingBubbleColor: UIColor,
        incomingTextColor: UIColor,
        outgoingTextColor: UIColor,
        composerBackground: UIColor,
        composerTextColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        self.incomingBubbleColor = incomingBubbleColor
        self.outgoingBubbleColor = outgoingBubbleColor
        self.incomingTextColor = incomingTextColor
        self.outgoingTextColor = outgoingTextColor
        self.composerBackground = composerBackground
        self.composerTextColor = composerTextColor
    }

    public static let light = ChatTheme(
        backgroundColor: .systemBackground,
        incomingBubbleColor: .secondarySystemBackground,
        outgoingBubbleColor: .systemBlue,
        incomingTextColor: .label,
        outgoingTextColor: .white,
        composerBackground: .secondarySystemBackground,
        composerTextColor: .label
    )
}
