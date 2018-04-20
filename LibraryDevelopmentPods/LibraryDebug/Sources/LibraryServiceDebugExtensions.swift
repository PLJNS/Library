//
//  LibraryServiceDebugExtensions.swift
//  LibraryDebug
//
//  Created by Paul Jones on 4/20/18.
//

import Foundation
import LibraryClient

extension LibraryService {
    public func populateWithRandomBooks() {
        for _ in 0...100 {
            add(book: Book.random) { (book, error) in
                ()
            }
        }
    }
}
