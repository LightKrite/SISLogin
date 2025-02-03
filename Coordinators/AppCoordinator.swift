//
//  AppCoordinator.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class AppCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        startCoordinator.start()
    }
}
