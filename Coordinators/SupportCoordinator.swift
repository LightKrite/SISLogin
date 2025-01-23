//
//  SupportCoordinator.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 23.1.25..
//

import UIKit

import UIKit

class SupportCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = SupportViewModel()
        let viewController = SupportViewController(viewModel: viewModel)
        
        viewController.onBackButtonTapped = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}


