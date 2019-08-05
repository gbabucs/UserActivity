//
//  CommentsCell.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import ActivityFramework

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var body: UILabel!
}

extension CommentsCell: Cell {
    
    func configure(for item: Comments) {
        
        self.name.text = item.name
        self.email.text = item.email
        self.body.text = item.body
    }
    
}
