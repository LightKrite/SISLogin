//
//  SMSCodeCoordinator.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class SMSCodeCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = SMSCodeViewModel()
        let smsCodeVC = SMSCodeViewController(viewModel: viewModel)

        smsCodeVC.onCodeVerified = { [weak self] in
            self?.showSuccessScreen()
        }

        navigationController.pushViewController(smsCodeVC, animated: true)
    }

    private func showSuccessScreen() {
        let successVC = UIViewController()
        successVC.view.backgroundColor = .white
        successVC.title = "Успешный вход"
        navigationController.pushViewController(successVC, animated: true)
    }
}
