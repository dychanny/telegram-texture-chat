import AsyncDisplayKit
import UIKit

public final class ChatViewController: ASDKViewController<ASDisplayNode>, ASTableDataSource, ASTableDelegate {
    private let tableNode = ASTableNode(style: .plain)
    private let composerNode = ComposerNode()

    private let theme: ChatTheme
    private let viewModel: ChatViewModel
    private var messages: [ChatMessage] = []

    public init(viewModel: ChatViewModel, theme: ChatTheme = .light) {
        self.viewModel = viewModel
        self.theme = theme
        super.init(node: ASDisplayNode())

        node.backgroundColor = theme.backgroundColor
        node.automaticallyManagesSubnodes = false
        node.addSubnode(tableNode)
        node.addSubnode(composerNode)

        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.view.separatorStyle = .none
        tableNode.view.keyboardDismissMode = .interactive

        composerNode.onSend = { [weak self] text in
            self?.viewModel.send(text: text)
        }

        viewModel.onMessagesChanged = { [weak self] items in
            DispatchQueue.main.async {
                self?.messages = items
                self?.tableNode.reloadData()
                self?.scrollToBottom(animated: true)
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        viewModel.start()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safe = view.safeAreaInsets
        let composerHeight: CGFloat = 64
        tableNode.frame = CGRect(x: 0, y: safe.top, width: view.bounds.width, height: view.bounds.height - safe.top - safe.bottom - composerHeight)
        composerNode.frame = CGRect(x: 0, y: tableNode.frame.maxY, width: view.bounds.width, height: composerHeight + safe.bottom)
    }

    public func numberOfSections(in tableNode: ASTableNode) -> Int { 1 }

    public func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    public func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let message = messages[indexPath.row]
        let theme = self.theme
        return {
            MessageTextCellNode(message: message, theme: theme)
        }
    }

    private func scrollToBottom(animated: Bool) {
        guard !messages.isEmpty else { return }
        let last = IndexPath(row: messages.count - 1, section: 0)
        tableNode.scrollToRow(at: last, at: .bottom, animated: animated)
    }
}
