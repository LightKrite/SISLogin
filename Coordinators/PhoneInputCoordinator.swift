//
//  PhoneInputCoordinator.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//
import UIKit

class PhoneInputCoordinator {
    private let navigationController: UINavigationController
    private let isRegistration: Bool

    init(navigationController: UINavigationController, isRegistration: Bool) {
        self.navigationController = navigationController
        self.isRegistration = isRegistration
    }

    func start() {
        print("PhoneInputCoordinator started")

        let viewModel = PhoneInputViewModel(isRegistration: isRegistration)
        let phoneInputVC = PhoneInputViewController(viewModel: viewModel)

        phoneInputVC.onCodeRequested = { [weak self] in
            self?.showSMSCode()
        }

        navigationController.pushViewController(phoneInputVC, animated: true)
    }

    private func showSMSCode() {
        let smsCodeCoordinator = SMSCodeCoordinator(navigationController: navigationController)
        smsCodeCoordinator.start()
    }
}
