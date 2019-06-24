//
//  HomeCoordinator.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-22.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: RootCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return self.navigationController }

    private lazy var navigationController: UINavigationController = {
        let navigationController = PNavigationController(rootController: nil)
        navigationController.navigationBar.tintColor = .backgroundColor
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return navigationController
    }()
    
    func start() {
        let home = HomeController(viewModel: HomeViewModel())
        navigationController.pushViewController(home, animated: false)
    }
}
