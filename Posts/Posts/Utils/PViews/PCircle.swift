//
//  PCircle.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-24.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class PCircle: UIView {
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.path = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2 - self.frame.size.height/2,
                                                y: 0.0,
                                                width: self.frame.size.height,
                                                height: self.frame.size.height))
    }
}

