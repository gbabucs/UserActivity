//
//  DataContoller.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation


class DataController: NSObject {
    
    func getUsers(completion: @escaping([Users]) -> Void) {
        DataAdapter.shared.fetchUsers { isSuccess, users in
            completion(users ?? [])
        }
    }
    
    func getPost(id userId: String, completion: @escaping([Posts]) -> Void) {
        DataAdapter.shared.fetchPosts(id: userId) { isSuccess, posts in
            completion(posts ?? [])
        }
    }
    
    func getComment(id postId: String, completion: @escaping([Comments]) -> Void) {
        DataAdapter.shared.fetchComments(id: postId) { isSuccess, comments in
            completion(comments ?? [])
        }
    }
    
    func getAlbum(id userId: String, completion: @escaping([Albums]) -> Void) {
        DataAdapter.shared.fetchAlbums(id: userId) { isSuccess, albums in
            completion(albums ?? [])
        }
    }
    
    func getPhoto(id albumId: String, completion: @escaping([Photos]) -> Void) {
        DataAdapter.shared.fetchPhotos(id: albumId) { isSuccess, photos in
            completion(photos ?? [])
        }
    }
    
}
