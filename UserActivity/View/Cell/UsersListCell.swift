//
//  UsersListCell.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import ActivityFramework

class UsersListCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var address: UILabel!
}

extension UsersListCell: Cell {
    
    func configure(for item: Users) {
        self.userName.text = item.username
        
        let street = item.address?.street ?? ""
        let suite = item.address?.suite ?? ""
        let city = item.address?.city ?? ""
        let zipCode = item.address?.zipcode ?? ""
        
        self.address.text = street + ", " + suite + ", " + city + ", " + zipCode
    }
    
}
