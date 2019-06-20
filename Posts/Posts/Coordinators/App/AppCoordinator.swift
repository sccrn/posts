//
//  AppCoordinator.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

///This coordinator is the first one and will be the rootViewController
class AppCoordinator: RootCoordinator {
    
    ///These are the RootCoordinator's protocol.
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return navigationController }
    
    //This is navigation controller and where will be import
    //the navigationController's custom.
    private lazy var navigationController: UINavigationController = {
        let navigationController = PNavigationController(rootController: nil)
        return navigationController
    }()
    
    /// Window to manage
    let window: UIWindow
    
    //The initialization of our window.
    public init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    /// Starts the coordinator
    public func start() {
    }
}