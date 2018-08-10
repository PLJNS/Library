//
//  BookExtensions.swift
//  LibraryService
//
//  Created by Paul Jones on 4/21/18.
//

import Foundation

extension Book : Equatable {
    public static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.author == rhs.author &&
            lhs.categories == rhs.categories &&
            lhs.id == rhs.id &&
            lhs.lastCheckedOut == rhs.lastCheckedOut &&
            lhs.lastCheckedOutBy == rhs.lastCheckedOutBy &&
            lhs.publisher == rhs.publisher &&
            lhs.title == rhs.title &&
            lhs.url == rhs.url
    }
}

extension Book: CustomStringConvertible { }
extension BookProtocol where Self: CustomStringConvertible {
    public var description: String {
        return [author, title, publisher, categories].compactMap{ $0 }.joined(separator: ", ")
    }
}

extension Collection where Element == BookProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        let lhsIds = lhs.compactMap({ $0.id })
        let rhsIds = rhs.compactMap({ $0.id })
        return lhsIds == rhsIds
    }
}
