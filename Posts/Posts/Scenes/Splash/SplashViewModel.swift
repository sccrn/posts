//
//  SplashViewModel.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-20.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

protocol SplashCoordinatorDelegate: class {
    func moveForwardFlow(_ controller: SplashController)
}

class SplashViewModel {
    weak var coordinator: SplashCoordinatorDelegate?
    
    init(coordinator: SplashCoordinatorDelegate) {
        self.coordinator = coordinator
    }
}
