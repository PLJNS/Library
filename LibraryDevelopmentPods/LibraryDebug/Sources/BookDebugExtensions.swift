//
//  LibraryServiceDebugExtensions.swift
//  LibraryDebug
//
//  Created by Paul Jones on 4/20/18.
//

import LibraryService
import LibrarySwiftExtensions

public extension BookProtocol {
    public static var random: Book {
        return Book(author: String.random,
                    categories: String.random,
                    id: Int.random,
                    lastCheckedOutBy: String.random,
                    publisher: String.random,
                    title: String.random)
    }
}
