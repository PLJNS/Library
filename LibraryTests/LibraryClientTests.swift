//
//  LibraryTests.swift
//  LibraryTests
//
//  Created by Paul Jones on 4/18/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import XCTest
@testable import LibraryClient
@testable import LibraryExtensions

class LibraryClientTests: XCTestCase {

    let book = Book(author: nil,
                    categories: nil,
                    id: 0,
                    lastCheckedOut: nil,
                    lastCheckedOutBy: nil,
                    publisher: nil,
                    title: nil,
                    url: nil)

    func testGetAllBooksURL() {
        let path = LibraryClient.Path.getAll
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books")
        XCTAssertEqual(path.method.rawValue,
                       "GET")
    }

    func testAddBookURL() {
        let path = LibraryClient.Path.add(book: book)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books")
        XCTAssertEqual(path.method.rawValue,
                       "POST")

    }

    func testGetBookURL() {
        let path = LibraryClient.Path.get(bookId: 0)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/0")
        XCTAssertEqual(path.method.rawValue,
                       "GET")

    }

    func testUpdateBookURL() {
        let path = LibraryClient.Path.update(book: book)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/0")
        XCTAssertEqual(path.method.rawValue,
                       "PUT")

    }

    func testDeleteBookURL() {
        let path = LibraryClient.Path.delete(book: book)
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/0")
        XCTAssertEqual(path.method.rawValue,
                       "DELETE")

    }

    func testDeleteAllURL() {
        let path = LibraryClient.Path.deleteAll
        XCTAssertEqual(path.url!.absoluteString,
                       "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/")
        XCTAssertEqual(path.method.rawValue,
                       "DELETE")

    }
}
