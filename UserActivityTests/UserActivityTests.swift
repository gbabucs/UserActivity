//
//  UserActivityTests.swift
//  UserActivityTests
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import XCTest
@testable import UserActivity

class UserActivityTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJSONMappingForUserData() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Users", withExtension: "json") else {
            XCTFail("Missing file: Users.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let users = DataAdapter.shared.processData(type: [Users].self, response: json)
        
        XCTAssertEqual(users?.count, 10)
        XCTAssertTrue(users?.first?.address?.geo?.lat == "-37.3159")
        XCTAssertTrue(users?.last?.address?.city == "Lebsackbury")
        
        XCTAssertNotEqual(users?.count, 15)
        XCTAssertFalse(users?.first?.name == "Ervin Howell")
        XCTAssertFalse(users?.first?.email == "Ervinhown@gmail.com")
    }
    
    func testJSONMappingForPostData() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Posts", withExtension: "json") else {
            XCTFail("Missing file: Posts.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let posts = DataAdapter.shared.processData(type: [Posts].self, response: json)
        
        XCTAssertEqual(posts?.count, 10)
        XCTAssertTrue(posts?.first?.userId == 1)
        XCTAssertTrue(posts?.first?.title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        
        XCTAssertNotEqual(posts?.count, 15)
        XCTAssertFalse(posts?.first?.userId == 4)
        XCTAssertFalse(posts?.first?.title == "occaecati excepturi optio reprehenderit")
    }

}
