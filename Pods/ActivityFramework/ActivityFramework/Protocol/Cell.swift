//
//  Cell.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

public protocol Cell: class {
    
    static var reuseIdentifier: String { get }
    
    associatedtype Codable
    
    func configure(for item: Codable)
}

public extension Cell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func configure(for item: Codable) {}
}
