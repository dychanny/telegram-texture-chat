import AsyncDisplayKit
import UIKit

public final class ChatListViewController: ASDKViewController<ASDisplayNode>, ASTableDataSource, ASTableDelegate {
    private let tableNode = ASTableNode(style: .plain)
    private let viewModel: ChatListViewModel
    private let chatBuilder: (ChatThread) -> UIViewController
    private var threads: [ChatThread] = []

    public init(viewModel: ChatListViewModel, chatBuilder: @escaping (ChatThread) -> UIViewController) {
        self.viewModel = viewModel
        self.chatBuilder = chatBuilder
        super.init(node: ASDisplayNode())

        node.backgroundColor = .systemBackground
        node.addSubnode(tableNode)

        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        navigationItem.largeTitleDisplayMode = .always

        viewModel.onThreadsChanged = { [weak self] items in
            DispatchQueue.main.async {
                self?.threads = items
                self?.tableNode.reloadData()
            }
        }
        viewModel.start()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableNode.frame = view.bounds
    }

    public func numberOfSections(in tableNode: ASTableNode) -> Int { 1 }

    public func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        threads.count
    }

    public func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let thread = threads[indexPath.row]
        return {
            ChatThreadCellNode(thread: thread)
        }
    }

    public func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        guard let thread = viewModel.thread(at: indexPath.row) else { return }
        let vc = chatBuilder(thread)
        navigationController?.pushViewController(vc, animated: true)
    }
}
