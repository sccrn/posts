//
//  HomeCell.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-22.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var postName: UILabel!
    
    func configure(postName: String) {
        self.postName.text = postName
    }
}
