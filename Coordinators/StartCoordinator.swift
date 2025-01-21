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

        // Обрабатываем запрос на вход
        startVC.onLoginRequested = { [weak self] in
            print("Navigating to PhoneInputCoordinator for login")
            self?.showPhoneInput()
        }

        // Обрабатываем запрос на регистрацию
        startVC.onRegistrationRequested = { [weak self] in
            print("Navigating to PhoneInputCoordinator for registration")
            self?.showPhoneInput()
        }

        navigationController.pushViewController(startVC, animated: true)
    }

    private func showPhoneInput() {
        print("showPhoneInput called with isRegistered: \(GlobalState.shared.isRegistered)")
        let phoneInputCoordinator = PhoneInputCoordinator(navigationController: navigationController)
        phoneInputCoordinator.start()
    }
}
