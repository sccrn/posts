//
//  DetailsCell.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-24.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class DetailsCell: UITableViewCell {
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var infoView: UIView!
    
    
    func configure(post: PostModel) {
        authorName.text = post.userName
        postDescription.text = post.body
        numberOfComments.text = "\(post.numberOfComments) comments in this post."
        setupInfoView()
    }
    
    private func setupInfoView() {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: infoView.bounds).cgPath
        circleLayer.strokeColor = UIColor.greenColor.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 3
        
        let gradient = CAGradientLayer()
        gradient.frame = infoView.bounds
        gradient.colors = [UIColor.pinkGradient.cgColor,
                           UIColor.backgroundColor.cgColor,
                           UIColor.greenColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.mask = circleLayer
        
        infoView.layer.addSublayer(gradient)
    }
}
