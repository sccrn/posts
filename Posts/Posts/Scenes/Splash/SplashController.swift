//
//  SplashController.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-20.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class SplashController: BaseController {
    @IBOutlet weak var logoImage: UIImageView!
    
    private var viewModel: SplashViewModel

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplash()
    }
   
    func setupSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
           self.viewModel.coordinator?.moveForwardFlow(self)
        })
    }
}
