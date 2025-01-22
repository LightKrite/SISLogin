//
//  PhoneInputCoordinator.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//
import UIKit

class PhoneInputCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("PhoneInputCoordinator initialized")
    }

    func start() {
        print("PhoneInputCoordinator.start() beginning")
        let viewModel = PhoneInputViewModel()
        let phoneInputVC = PhoneInputViewController(viewModel: viewModel)
        
        phoneInputVC.onPhoneNumberSubmitted = { [weak self] in
            self?.showSMSCode()
        }
        
        print("Current navigation stack: \(navigationController.viewControllers.count)")
        navigationController.pushViewController(phoneInputVC, animated: true)
        print("PhoneInputViewController pushed")
    }

    private func showSMSCode() {
        let smsCodeCoordinator = SMSCodeCoordinator(navigationController: navigationController)
        smsCodeCoordinator.start()
    }
}
