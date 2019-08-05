//
//  AlbumCell.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}

extension AlbumCell: Cell {
    
    func configure(for item: Albums) {
        self.title.text = item.title
    }
    
}
