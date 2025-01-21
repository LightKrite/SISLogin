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
        print("StartCoordinator initialized") // Отладочный вывод
    }

    func start() {
        print("StartCoordinator.start() called") // Отладочный вывод
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

        // Важно! Меняем pushViewController на setViewControllers
        navigationController.setViewControllers([startVC], animated: true)
    }

    private func showPhoneInput() {
        print("showPhoneInput called") // Отладочный вывод
        let phoneInputCoordinator = PhoneInputCoordinator(navigationController: navigationController)
        self.phoneInputCoordinator = phoneInputCoordinator
        phoneInputCoordinator.start()
    }
}
