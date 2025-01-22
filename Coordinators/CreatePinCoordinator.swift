import UIKit

class CreatePinCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("CreatePinCoordinator initialized")
    }
    
    func start() {
        print("CreatePinCoordinator.start() beginning")
        let viewModel = CreatePinViewModel()
        let createPinVC = CreatePinViewController(viewModel: viewModel)
        
        print("Current navigation stack before push: \(navigationController.viewControllers.count)")
        navigationController.pushViewController(createPinVC, animated: true)
        print("CreatePinViewController pushed")
    }
}
