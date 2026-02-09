import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let me = ChatUser(id: "me", displayName: "Me")
        let store = MessageStore()
        let socket = MockSocketService(me: me)
        let vm = ChatViewModel(me: me, store: store, socket: socket)

        let chat = ChatViewController(viewModel: vm)
        let nav = UINavigationController(rootViewController: chat)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
