//
//  DebugLibraryService.swift
//  LibraryDebug
//
//  Created by Paul Jones on 4/20/18.
//

import Foundation
import LibraryClient

public class DebugLibraryService: LibraryService {
    private var books: [Book] = []
    
    public override func getAllBooks(completion: @escaping ([Book]?, Error?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.books, nil)
        }
    }

    public override func add(book: Book, completion: @escaping (Book?, Error?) -> ()) {
        var aBook = book
        aBook.id = books.count
        books.append(aBook)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(aBook, nil)
        }
    }

    public override func getBook(withId id: Int, completion: @escaping (Book?, Error?) -> ()) {
        let book = books.first(where: { $0.id == id })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(book, nil)
        }
    }

    public override func update(book: Book, checkingOut: Bool? = false, completion: @escaping (Book?, Error?) -> ()) {
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

    public override func delete(bookId: Int, completion: @escaping (Book?, Error?) -> ()) {
        if let bookIndex = books.index(where: { $0.id == bookId }) {
            let book = books.remove(at: bookIndex)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(book, nil)
            }
        } else {
            completion(nil, nil)
        }
    }

    public override func delete(bookIds: [Int], completion: @escaping ([Book], [Error]?) -> ()) {
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

    public override func deleteAll(completion: @escaping (Error?) -> ()) {
        books = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(nil)
        }
    }
}
