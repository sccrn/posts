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
        navigationController.navigationBar.tintColor = .iconColor
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return navigationController
    }()
    
    func start() {
        let home = HomeController(viewModel: HomeViewModel())
        home.viewModel.coordinator = self
        navigationController.pushViewController(home, animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func moveToDetailsScreen(_ postSelected: PostModel) {
        let details = PostDetailsController(viewModel: PostDetailsViewModel(coordinator: self,
                                                                            post: postSelected))
        navigationController.pushViewController(details, animated: true)
    }
}

extension HomeCoordinator: PostDetailsCoordinatorDelegate {
    func moveToHomeScreen() {
        navigationController.popViewController(animated: true)
    }
}
