//
//  Coordinator.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

/// The Coordinator protocol
public protocol Coordinator: class {
    
    /// The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }
}

public extension Coordinator {
    
    /// Function to add a child coordinator to the parent coordinator.
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Function to remove a child coordinator from the parent coordinator.
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
