//
//  Request.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

public enum ApiRequestType: String {
    case PUT
    case POST
    case GET
    case DELETE
}

public enum ApiRequestURL {
    case users
    case posts(userId: String)
    case comments(postId: String)
    case albums(userId: String)
    case photos(albumId: String)
    
    var value: String {
        switch self {
        case .users: return "users"
        case .posts(let userId): return "posts?userId=" + userId
        case .comments(let postId): return "comments?postId=" + postId
        case .albums(let userId): return "albums?userId=" + userId
        case .photos(let albumId) :  return "photos?albumId=" + albumId
        }
    }
}

public class Request: NSObject {
    
    private let baseURL: String = "https://jsonplaceholder.typicode.com/"
    private var endpoint: String = "/"
    
    var requestMethod: ApiRequestType
    var requestURL: String {
        return baseURL + endpoint
    }
    
    public init(apiURL: ApiRequestURL , requestType: ApiRequestType = .GET ) {
        self.endpoint = apiURL.value
        self.requestMethod = requestType
    }
    
    public func performNetworkOperationWithData(completion: @escaping (_ isSuccess: Bool ,_ responseData: Data? ,_ error: Error?) -> Void) {
        
        if let url = URL(string: requestURL) {
            var request = URLRequest(url: url)
            request.httpMethod = requestMethod.rawValue
            
            NetworkConnector.networkRequest(with: request) { (data, response, error) in
                if let jsonData = data {
                    completion(true , jsonData, nil)
                } else if let requestError = error {
                    completion( false , nil , requestError)
                }
            }
        } else {
            completion(false, nil, nil)
        }
    }
    
    
}
