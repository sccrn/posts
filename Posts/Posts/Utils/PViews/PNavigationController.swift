//
//  PNavigationController.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-19.
//  Copyright © 2019 Sam. All rights reserved.
//

import UIKit

///This is the app's navigationController and in here it's gonna customized.
class PNavigationController: UINavigationController {
    
    //Our navigationBar will be the navigationBar of our navigationController that will be customized in this init.
    convenience init(rootController: UIViewController? = nil) {
        self.init(navigationBarClass: PNavigationBar.self, toolbarClass: nil)
        
        if let rootViewController = rootController { viewControllers = [rootViewController] }
    }
}
