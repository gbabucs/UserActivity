//
//  PhotoCollectionCell.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import Nuke

class PhotoCollectionCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
}

extension PhotoCollectionCell: Cell {
    
    func configure(for item: Photos) {
        
        guard let url = URL(string: item.thumbnailUrl ?? "")
            else { return self.imageView.image = UIImage(named: "placeholder") }
        
        imageView.layer.masksToBounds = true
        Nuke.loadImage(with: url, into: self.imageView)
    }
    
}
