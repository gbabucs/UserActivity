//
//  PostsListCell.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import ActivityFramework

class PostsListCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
}

extension PostsListCell: Cell {
    
    func configure(for item: Posts) {
        self.title.text = item.title
        self.body.text = item.body
    }
    
}
