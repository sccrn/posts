//
//  UITableViewCell.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-22.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    
    ///Return identifier with the same name of the subclass
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
