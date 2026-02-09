import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
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
        nav.modalPresentationStyle = .fullScreen

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
