//
//  Comments.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 2, 2019

import Foundation

struct Comments : Codable {

        let body : String?
        let email : String?
        let id : Int?
        let name : String?
        let postId : Int?

        enum CodingKeys: String, CodingKey {
                case body = "body"
                case email = "email"
                case id = "id"
                case name = "name"
                case postId = "postId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                body = try values.decodeIfPresent(String.self, forKey: .body)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        }

}
