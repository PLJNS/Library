//
//  LibraryService.swift
//  LibraryClient
//
//  Created by Paul Jones on 4/19/18.
//

import Foundation

open class LibraryService {
    open static let shared = LibraryService()
    private let client = LibraryClient(withSession: URLSession(configuration: .default))
    private init() { }

    open func getAllBooks(completion: @escaping ([Book]?, Error?) -> ()) {
        client.load(.getAll, completion: completion)
    }

    open func add(book: Book, completion: @escaping (Book?, Error?) -> ()) {
        client.load(.add(book: book), completion: completion)
    }

    open func getBook(withId id: Int, completion: @escaping (Book?, Error?) -> ()) {
        client.load(.get(bookId: id), completion: completion)
    }

    open func update(book: Book, checkingOut: Bool = false, completion: @escaping (Book?, Error?) -> ()) {
        var book = book
        book.lastCheckedOutBy = checkingOut ? book.lastCheckedOutBy : nil
        client.load(.update(book: book), completion: completion)
    }

    open func delete(bookId: Int, completion: @escaping (Book?, Error?) -> ()) {
        client.load(.delete(bookId: bookId), completion: completion)
    }

    open func deleteAll(completion: @escaping (Error?) -> ()) {
        client.load(.deleteAll, completion: { (_: Book?, error) in
            completion(error)
        })
    }

    open func delete(bookIds: [Int], completion: @escaping ([Book], [Error]?) -> ()) {
        var books: [Book] = [], errors: [Error] = [], dispatchGroup = DispatchGroup()
        for bookId in bookIds {
            dispatchGroup.enter()
            delete(bookId: bookId) { (book, error) in
                if let book = book { books.append(book) }
                if let error = error { errors.append(error) }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) { completion(books, errors) }
    }
}
