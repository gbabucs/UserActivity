//
//  Addres.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 2, 2019

import Foundation

struct Addres : Codable {

        let city : String?
        let geo : Geo?
        let street : String?
        let suite : String?
        let zipcode : String?

        enum CodingKeys: String, CodingKey {
                case city = "city"
                case geo = "geo"
                case street = "street"
                case suite = "suite"
                case zipcode = "zipcode"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                city = try values.decodeIfPresent(String.self, forKey: .city)
                geo = Geo(from: decoder)
                street = try values.decodeIfPresent(String.self, forKey: .street)
                suite = try values.decodeIfPresent(String.self, forKey: .suite)
                zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
        }

}
