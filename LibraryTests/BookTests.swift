//
//  BookTests.swift
//  LibraryTests
//
//  Created by Paul Jones on 4/19/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import XCTest
@testable import LibraryService

class BookTests: XCTestCase {

    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()

    func testSingleComparison() {
        let book1 = Book(author: "1", categories: "2", id: 3, lastCheckedOutBy: "4", publisher: "5", title: "6")
        let book2 = Book(author: "1", categories: "2", id: 3, lastCheckedOutBy: "4", publisher: "5", title: "6")
        XCTAssertEqual(book1, book2)
    }

    func testMultipleComparison() {
        let book1 = Book(author: "1", categories: "2", id: 3, lastCheckedOutBy: "4", publisher: "5", title: "6")
        let book2 = Book(author: "7", categories: "8", id: 9, lastCheckedOutBy: "10", publisher: "11", title: "12")
        let books1 = [book1, book2]

        let book3 = Book(author: "1", categories: "2", id: 3, lastCheckedOutBy: "4", publisher: "5", title: "6")
        let book4 = Book(author: "7", categories: "8", id: 9, lastCheckedOutBy: "10", publisher: "11", title: "12")
        let books2 = [book3, book4]

        XCTAssertEqual(books1, books2)
    }
    
    func testJSONDecodingSingleBook() {
        let dateString = "2018-04-19 17:46:26 GMT"
        let expectedDate = DateFormatter.libraryDateFormatter.date(from: dateString)

        let json = """
        {
        "author": "Ash Maurya",
        "categories": "process",
        "id": 1,
        "lastCheckedOut": "\(dateString)",
        "lastCheckedOutBy": null,
        "publisher": "O'REILLY",
        "title": "Running Lean",
        "url": "/books/1/"
        }
        """
        if let bookJSONData = json.data(using: .utf8) {
            do {
                let book = try jsonDecoder.decode(Book.self, from: bookJSONData)
                XCTAssertEqual(book.author, "Ash Maurya")
                XCTAssertEqual(book.categories, "process")
                XCTAssertEqual(book.id, 1)
                XCTAssertEqual(book.lastCheckedOut, expectedDate)
                XCTAssertEqual(book.lastCheckedOutBy, nil)
                XCTAssertEqual(book.publisher, "O'REILLY")
                XCTAssertEqual(book.title, "Running Lean")
                XCTAssertEqual(book.url?.absoluteString, "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/1/")
            } catch {
                XCTFail()
            }

        } else {
            XCTFail()
        }
    }

    func testJSONEncodingSingleBook() {
        let expectedDate = Date()
        let dateString = DateFormatter.libraryDateFormatter.string(from: expectedDate)
        var book = Book(author: "Ash Maurya",
                        categories: "process",
                        id: 1,
                        lastCheckedOutBy: nil,
                        publisher: "O'REILLY",
                        title: "Running Lean")
        book.lastCheckedOut = expectedDate
        do {
            let data = try jsonEncoder.encode(book)
            let json = String(data: data, encoding: .utf8)
            let expectation = "{\"author\":\"Ash Maurya\",\"id\":1,\"categories\":\"process\",\"title\":\"Running Lean\",\"publisher\":\"O\'REILLY\",\"lastCheckedOut\":\"\(dateString)\",\"url\":\"\\/books\\/1\"}"
            XCTAssertEqual(json, expectation)
        } catch {
            XCTFail()
        }
    }

    func testJSONDecodingMultipleBooks() {
        let dateString = "2018-04-19 17:46:26 GMT"
        let expectedDate = DateFormatter.libraryDateFormatter.date(from: dateString)

        let json = """
        [{
        "author": "Ash Maurya",
        "categories": "process",
        "id": 1,
        "lastCheckedOut": "\(dateString)",
        "lastCheckedOutBy": null,
        "publisher": "O'REILLY",
        "title": "Running Lean",
        "url": "/books/1/"
        },
        {
        "author": "Ash Maurya",
        "categories": "process",
        "id": 1,
        "lastCheckedOut": "\(dateString)",
        "lastCheckedOutBy": null,
        "publisher": "O'REILLY",
        "title": "Running Lean",
        "url": "/books/1/"
        }]
        """
        if let bookJSONData = json.data(using: .utf8) {
            do {
                let books = try jsonDecoder.decode([Book].self, from: bookJSONData)
                for book in books {
                    XCTAssertEqual(book.author, "Ash Maurya")
                    XCTAssertEqual(book.categories, "process")
                    XCTAssertEqual(book.id, 1)
                    XCTAssertEqual(book.lastCheckedOut, expectedDate)
                    XCTAssertEqual(book.lastCheckedOutBy, nil)
                    XCTAssertEqual(book.publisher, "O'REILLY")
                    XCTAssertEqual(book.title, "Running Lean")
                    XCTAssertEqual(book.url?.absoluteString, "https://prolific-interview.herokuapp.com/5acb830d057b610009a97cb8/books/1/")
                }
            } catch {
                XCTFail()
            }

        } else {
            XCTFail()
        }
    }

    func testJSONEncodingMultipleBooks() {
        let expectedDate = Date()
        let dateString = DateFormatter.libraryDateFormatter.string(from: expectedDate)
        var book = Book(author: "Ash Maurya",
                        categories: "process",
                        id: 1,
                        lastCheckedOutBy: nil,
                        publisher: "O'REILLY",
                        title: "Running Lean")
        book.lastCheckedOut = expectedDate
        let books = [book, book]
        do {
            let data = try jsonEncoder.encode(books)
            let json = String(data: data, encoding: .utf8)
            let expectation = "[{\"author\":\"Ash Maurya\",\"id\":1,\"categories\":\"process\",\"title\":\"Running Lean\",\"publisher\":\"O\'REILLY\",\"lastCheckedOut\":\"\(dateString)\",\"url\":\"\\/books\\/1\"},{\"author\":\"Ash Maurya\",\"id\":1,\"categories\":\"process\",\"title\":\"Running Lean\",\"publisher\":\"O\'REILLY\",\"lastCheckedOut\":\"\(dateString)\",\"url\":\"\\/books\\/1\"}]"
            XCTAssertEqual(json, expectation)
        } catch {
            XCTFail()
        }
    }
    
}
