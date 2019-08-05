//
//  Users.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 2, 2019

import Foundation
import SwiftyJSON

struct Users : Codable {

        let address : Addres?
        let company : Company?
        let email : String?
        let id : Int?
        let name : String?
        let phone : String?
        let username : String?
        let website : String?

        enum CodingKeys: String, CodingKey {
                case address = "address"
                case company = "company"
                case email = "email"
                case id = "id"
                case name = "name"
                case phone = "phone"
                case username = "username"
                case website = "website"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                address = try values.decodeIfPresent(Addres.self, forKey: .address)
                company = try values.decodeIfPresent(Company.self, forKey: .company)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                phone = try values.decodeIfPresent(String.self, forKey: .phone)
                username = try values.decodeIfPresent(String.self, forKey: .username)
                website = try values.decodeIfPresent(String.self, forKey: .website)
        }

}

//extension Users {
//    
//    var userName: String {
//        return self.userName
//    }
//    
//    var addresses: String {
//        let street = self.address?.street ?? ""
//        let suite = self.address?.suite ?? ""
//        let city = self.address?.city ?? ""
//        let zipCode = self.address?.zipcode ?? ""
//        
//        return street + suite + city + zipCode
//    }
//}
