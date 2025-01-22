//
//  Untitled.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class StartCoordinator {
    private let navigationController: UINavigationController
    private var phoneInputCoordinator: PhoneInputCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("StartCoordinator initialized")
    }

    func start() {
        print("StartCoordinator.start() called")
        let viewModel = StartViewModel()
        let startVC = StartViewController(viewModel: viewModel)

        // Устанавливаем обработчики
        startVC.onLoginRequested = { [weak self] in
            print("Login requested, calling showPhoneInput")
            GlobalState.shared.setRegistrationStatus(true)
            self?.showPhoneInput()
        }

        startVC.onRegistrationRequested = { [weak self] in
            print("Registration requested, calling showPhoneInput")
            GlobalState.shared.setRegistrationStatus(false)
            self?.showPhoneInput()
        }

        // Проверяем, что navigationController не nil
        print("Setting root view controller")
        navigationController.setViewControllers([startVC], animated: false)
    }

    private func showPhoneInput() {
        print("Creating PhoneInputCoordinator")
        let coordinator = PhoneInputCoordinator(navigationController: navigationController)
        self.phoneInputCoordinator = coordinator
        
        print("Starting PhoneInputCoordinator")
        coordinator.start()
    }
}
