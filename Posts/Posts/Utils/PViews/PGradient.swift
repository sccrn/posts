//
//  PGradient.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-22.
//  Copyright © 2019 Sam. All rights reserved.
//

import UIKit

///This class will do the view's gradient in Splash's screen,
///we're using IBDesignable to set up in the XIB.
///For this class, we're putting clear colors to be generic.
@IBDesignable
class PGradient: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet { setupGradient() }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet { setupGradient() }
    }
    
    override class var layerClass: AnyClass {
        get { return CAGradientLayer.self }
    }
    
    ///Creation of our layer and it's gonna present.
    func setupGradient() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map { $0.cgColor }
        layer.startPoint = CGPoint(x: 0.5, y: 0.45)
        layer.endPoint = CGPoint (x: 0.75, y: 1)
    }
}
