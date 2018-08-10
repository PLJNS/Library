//
//  LibraryTests.swift
//  LibraryTests
//
//  Created by Paul Jones on 4/18/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import XCTest
@testable 
@testable 
@testable 

class LibraryClientTests: XCTestCase {

    let book = Book(author: nil,
                    categories: nil,
                    id: 0,
                    lastCheckedOutBy: nil,
                    publisher: nil,
                    title: nil)

    func testGetAllBooksURL() {
        let path = LibraryPath.getAll
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/")
        XCTAssertEqual(path.method.rawValue,
                       "GET")
    }

    func testAddBookURL() {
        let path = LibraryPath.add(book: book)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/")
        XCTAssertEqual(path.method.rawValue,
                       "POST")

    }

    func testGetBookURL() {
        let path = LibraryPath.get(bookId: 0)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/0/")
        XCTAssertEqual(path.method.rawValue,
                       "GET")

    }

    func testUpdateBookURL() {
        let path = LibraryPath.update(book: book)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/0/")
        XCTAssertEqual(path.method.rawValue,
                       "PUT")

    }

    func testDeleteBookURL() {
        let path = LibraryPath.delete(bookId: 0)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/0/")
        XCTAssertEqual(path.method.rawValue,
                       "DELETE")

    }

    func testDeleteAllURL() {
        let path = LibraryPath.deleteAll
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/clean/")
        XCTAssertEqual(path.method.rawValue,
                       "DELETE")

    }
}
