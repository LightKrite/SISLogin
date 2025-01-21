//
//  Untitled.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class StartCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = StartViewModel()
        let startVC = StartViewController(viewModel: viewModel)

        startVC.onLoginRequested = { [weak self] in
            print("Navigating to PhoneInputCoordinator for login")
            self?.showPhoneInput(isRegistration: false)
        }

        startVC.onRegistrationRequested = { [weak self] in
            print("Navigating to PhoneInputCoordinator for registration")
            self?.showPhoneInput(isRegistration: true)
        }

        navigationController.pushViewController(startVC, animated: true)
    }

    private func showPhoneInput(isRegistration: Bool) {
        print("showPhoneInput called with isRegistration: \(isRegistration)")
        let phoneInputCoordinator = PhoneInputCoordinator(navigationController: navigationController, isRegistration: isRegistration)
        phoneInputCoordinator.start()
    }
}
