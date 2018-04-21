//
//  LibraryPath.swift
//  LibraryService
//
//  Created by Paul Jones on 4/21/18.
//

import Foundation
import CodableClient

public enum LibraryPath: URLConvertible {
    case getAll
    case add(book: Book)
    case update(book: Book)
    case get(bookId: Int)
    case delete(bookId: Int)
    case deleteAll

    public var httpBody: Codable? {
        switch self {
        case .update(let book), .add(let book):
            return book
        default:
            return nil
        }
    }

    public var url: URL? {
        switch self {
        case .getAll, .add(_):
            return LibraryPath.buildURL(withPath: "/books/")
        case .get(let bookId), .delete(let bookId):
            return LibraryPath.buildURL(withPath: "/books/\(bookId)/")
        case .update(let book):
            if let bookId = book.id { return LibraryPath.buildURL(withPath: "/books/\(bookId)/") }
            else { return nil }
        case .deleteAll:
            return LibraryPath.buildURL(withPath: "/clean/")
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .getAll, .get(_):
            return .get
        case .add(_):
            return .post
        case .update(_):
            return .put
        case .delete(_), .deleteAll:
            return .delete
        }
    }

    private static let scheme = "https"
    internal static let host = "prolific-interview.herokuapp.com"
    internal static let id = "5acb830d057b610009a97cb8"

    internal static func buildURL(withPath path: String) -> URL? {
        return URL(scheme: LibraryPath.scheme,
                   host: LibraryPath.host,
                   path: "/\(LibraryPath.id)\(path)")
    }
}
