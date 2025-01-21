import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        let startCoordinator = StartCoordinator(navigationController: navigationController)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
        startCoordinator.start()
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
