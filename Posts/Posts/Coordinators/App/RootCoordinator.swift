//
//  RootCoordinator.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

public protocol RootControllerCoordinator: class {
    //This rootViewController is the root of the coordinators.
    //It can be used to dismiss the coordinator from the view hierarchy.
    var rootViewController: UIViewController { get }
    func start()
}

///The typealias is been implemented to use this RootCoordinator to provides a root UIViewController
public typealias RootCoordinator = Coordinator & RootControllerCoordinator

