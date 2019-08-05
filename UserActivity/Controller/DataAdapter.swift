//
//  File.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

class DataAdapter {
    
    static let shared = DataAdapter()
    
    typealias GetListOfUserCompletionHandler = (_ isSuccess: Bool, _ users: [Users]?) -> Void
    typealias GetListOfPostCompletionHandler = (_ isSuccess: Bool, _ posts: [Posts]?) -> Void
    typealias GetListOfCommentCompletionHandler = (_ isSuccess: Bool, _ comments: [Comments]?) -> Void
    typealias GetListOfAlbumCompletionHandler = (_ isSuccess: Bool, _ albums: [Albums]?) -> Void
    typealias GetListOfPhotoCompletionHandler = (_ isSuccess: Bool, _ photos: [Photos]?) -> Void
    typealias DataCompletionHandler<T: Codable> = (_ success: Bool, _ response: T?) -> Void
    
    func fetchUsers(completion: @escaping GetListOfUserCompletionHandler) {
        let request = Request(apiURL: .users, requestType: .GET)
    
        fetchData(from: request, type: [Users].self, completion: completion)
    }
    
    func fetchPosts(id: String, completion: @escaping GetListOfPostCompletionHandler) {
        let request = Request(apiURL: .posts(userId: id), requestType: .GET)
        
        fetchData(from: request, type: [Posts].self, completion: completion)
    }
    
    func fetchComments(id: String, completion: @escaping GetListOfCommentCompletionHandler) {
        let request = Request(apiURL: .comments(postId: id), requestType: .GET)
        
        fetchData(from: request, type: [Comments].self, completion: completion)
    }
    
    func fetchAlbums(id: String, completion: @escaping GetListOfAlbumCompletionHandler) {
        let request = Request(apiURL: .albums(userId: id), requestType: .GET)
        
        fetchData(from: request, type: [Albums].self, completion: completion)
    }
    
    func fetchPhotos(id: String, completion: @escaping GetListOfPhotoCompletionHandler) {
        let request = Request(apiURL: .photos(albumId: id), requestType: .GET)
        
        fetchData(from: request, type: [Photos].self, completion: completion)
    }
    
    private func fetchData<T: Codable>(from request: Request, type: T.Type , completion: @escaping (_ success: Bool, _ response: T?) -> Void) {
        request.performNetworkOperationWithData { (success, response, error) in
            
            let result = self.processData(type: type, response: response)
            DispatchQueue.main.async { completion(true, result) }
        }
    }
    
    func processData<T: Codable>(type: T.Type, response: Data?) -> T? {
        var result: T? = nil
        
        if let jsondata = response,
            let object = try? JSONDecoder().decode(type.self, from: jsondata) {
            result = object
        }
        
        return result
    }
}
