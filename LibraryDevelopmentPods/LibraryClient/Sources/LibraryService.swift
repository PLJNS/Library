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

    public func populateWithRandomBooks() {
        for _ in 0...100 {
            add(book: Book.randomBook()) { (book, error) in
                ()
            }
        }
    }

    public func getAllBooks(completion: @escaping ([Book]?, Error?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.books, nil)
        }
//        client.load(.getAll, completionHandler: completion)
    }

    public func add(book: Book, completion: @escaping (Book?, Error?) -> ()) {
        var aBook = book
        aBook.id = books.count
        books.append(aBook)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(aBook, nil)
        }
    }

    public func getBook(withId id: Int, completion: @escaping (Book?, Error?) -> ()) {
        let book = books.first(where: { $0.id == id })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(book, nil)
        }
    }

    public func update(book: Book, completion: @escaping (Book?, Error?) -> ()) {
        if let bookIndex = books.index(where: { book.id == $0.id }) {
            let _ = books.remove(at: bookIndex)
            books.insert(book, at: bookIndex)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(book, nil)
            }
        } else {
            completion(nil, nil)
        }
    }

    public func delete(bookId: Int, completion: @escaping (Book?, Error?) -> ()) {
        if let bookIndex = books.index(where: { $0.id == bookId }) {
            let book = books.remove(at: bookIndex)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(book, nil)
            }
        } else {
            completion(nil, nil)
        }
    }

    public func delete(bookIds: [Int], completion: @escaping ([Book], Error?) -> ()) {
        var books: [Book] = []
        let dispatchGroup = DispatchGroup()
        for bookId in bookIds {
            dispatchGroup.enter()
            delete(bookId: bookId) { (book, error) in
                if let book = book {
                    books.append(book)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(books, nil)
        }
    }

    public func deleteAll(completion: @escaping (Error?) -> ()) {
        books = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(nil)
        }
    }
}
