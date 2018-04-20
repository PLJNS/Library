//
//  LibraryService.swift
//  LibraryClient
//
//  Created by Paul Jones on 4/19/18.
//

import Foundation

public class LibraryService {

    public static let shared = LibraryService()

    let client = LibraryClient(withSession: URLSession(configuration: .default))

    private var books: [Book] = []

    public func getAllBooks(completion: @escaping ([Book]?, Error?) -> ()) {
        completion(books, nil)
//        client.load(.getAll, completionHandler: completion)
    }

    public func add(book: Book, completion: @escaping (Book?, Error?) -> ()) {
        var aBook = book
        aBook.id = books.count
        books.append(aBook)
        completion(aBook, nil)
    }

    public func getBook(withId id: Int, completion: @escaping (Book?, Error?) -> ()) {
        let book = books.first(where: { $0.id == id })
        completion(book, nil)
    }

    public func update(book: Book, completion: @escaping (Book?, Error?) -> ()) {
        if let bookIndex = books.index(where: { book.id == $0.id }) {
            let _ = books.remove(at: bookIndex)
            books.insert(book, at: bookIndex)
            completion(book, nil)
        }

        completion(nil, nil)
    }

    public func delete(bookId: Int, completion: @escaping (Book?, Error?) -> ()) {
        if let bookIndex = books.index(where: { $0.id == bookId }) {
            let book = books.remove(at: bookIndex)
            completion(book, nil)
        }

        completion(nil, nil)
    }

    public func deleteAll(completion: @escaping (Error?) -> ()) {
        books = []
        completion(nil)
    }
}
