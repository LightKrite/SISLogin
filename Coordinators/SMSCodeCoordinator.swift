//
//  SMSCodeCoordinator.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class SMSCodeCoordinator {
    private let navigationController: UINavigationController
    private var createPinCoordinator: CreatePinCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("SMSCodeCoordinator initialized")
    }

    func start() {
        print("SMSCodeCoordinator.start() beginning")
        let viewModel = SMSCodeViewModel()
        let smsCodeVC = SMSCodeViewController(viewModel: viewModel)

        smsCodeVC.onCodeVerified = { [weak self] in
            print("SMS code verified, transitioning to CreatePinCoordinator")
            self?.showCreatePin()
        }

        navigationController.pushViewController(smsCodeVC, animated: true)
        print("SMSCodeViewController pushed")
    }

    private func showCreatePin() {
        print("Starting transition to CreatePin screen")
        let coordinator = CreatePinCoordinator(navigationController: navigationController)
        self.createPinCoordinator = coordinator
        print("CreatePinCoordinator stored, starting coordinator")
        
        DispatchQueue.main.async { [weak self] in
            self?.createPinCoordinator?.start()
            print("CreatePinCoordinator started")
        }
    }
}
