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
    }

    func start() {
        print("PhoneInputCoordinator started with isRegistered: \(GlobalState.shared.isRegistered)")
        let viewModel = PhoneInputViewModel()
        let phoneInputVC = PhoneInputViewController(viewModel: viewModel)
        navigationController.pushViewController(phoneInputVC, animated: true)
    }

    private func showSMSCode() {
        let smsCodeCoordinator = SMSCodeCoordinator(navigationController: navigationController)
        smsCodeCoordinator.start()
    }
}
