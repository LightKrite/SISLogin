import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var startCoordinator: StartCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        print("Setting up window and navigation")
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()

        startCoordinator = StartCoordinator(navigationController: navigationController)
        startCoordinator?.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window

        print("Window setup complete")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Этот метод вызывается при завершении работы сцены.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена становится активной.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена переходит в фоновый режим.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена возвращается в активное состояние.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена переходит в фоновый режим.
    }
}
