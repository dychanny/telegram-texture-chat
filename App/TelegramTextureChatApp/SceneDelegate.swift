import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let listVM = ChatListViewModel()
        let list = ChatListViewController(viewModel: listVM) { _ in
            let me = ChatUser(id: "me", displayName: "Me")
            let store = MessageStore()
            let socket = MockSocketService(me: me)
            let vm = ChatViewModel(me: me, store: store, socket: socket)
            return ChatViewController(viewModel: vm)
        }

        let nav = UINavigationController(rootViewController: list)
        nav.navigationBar.prefersLargeTitles = true

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}
