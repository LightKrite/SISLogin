//
//  PhoneInputCoordinator.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//
import UIKit

class PhoneInputCoordinator {
    private let navigationController: UINavigationController
    private var smsCodeCoordinator: SMSCodeCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("PhoneInputCoordinator initialized")
    }

    func start() {
        print("PhoneInputCoordinator.start() beginning")
        let viewModel = PhoneInputViewModel()
        let phoneInputVC = PhoneInputViewController(viewModel: viewModel)
        
        phoneInputVC.onPhoneNumberSubmitted = { [weak self] in
            print("Phone number submitted, showing SMS code screen")
            self?.showSMSCode()
        }
        
        print("Current navigation stack: \(navigationController.viewControllers.count)")
        navigationController.pushViewController(phoneInputVC, animated: true)
        print("PhoneInputViewController pushed")
    }

    private func showSMSCode() {
        print("Creating SMSCodeCoordinator")
        let coordinator = SMSCodeCoordinator(navigationController: navigationController)
        self.smsCodeCoordinator = coordinator
        coordinator.start()
    }
}
