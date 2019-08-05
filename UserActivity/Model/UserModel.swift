//
//  UserModel.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

class UserModel {
    
    var company: Company?
    var email: String?
    var id: Int?
    var name: String?
    var phone: String?
    var username: String?
    var website: String?
    var address: Addres?
    
    var addressInfo: String? {
        let street = address?.street ?? ""
        let suite = address?.suite ?? ""
        let city = address?.city ?? ""
        let zipCode = address?.zipcode ?? ""
        
        return street + suite + city + zipCode
    }
    
    var companyInfo: String? {
        let name = company?.name ?? ""
        let catchPhrase = company?.catchPhrase ?? ""
        let bs = company?.bs ?? ""
        
        return name + catchPhrase + bs
    }
    
    init(with user: Users) {
        
        id = user.id
        name = user.name
        phone = user.phone
        username = user.username
        website = user.website
        address = user.address
        
    }
}
