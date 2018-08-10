//
//  Book.swift
//  LibraryClient
//
//  Created by Paul Jones on 4/18/18.
//

import Foundation

public struct Book: BookProtocol, Codable {
    public var author: String?
    public var categories: String?
    public var id: Int?
    public var lastCheckedOut: Date?
    public var lastCheckedOutBy: String?
    public var publisher: String?
    public var title: String?
    public var url: URL?

    public var lastCheckedOutString: String? {
        if let lastCheckedOut = lastCheckedOut, let lastCheckedOutBy = lastCheckedOutBy {
            return "\(lastCheckedOutBy) @ \(DateFormatter.displayDateFormatter.string(from: lastCheckedOut))"
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case author
        case categories
        case id
        case lastCheckedOut
        case lastCheckedOutBy
        case publisher
        case title
        case url
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try? container.decode(String.self, forKey: .author)
        categories = try? container.decode(String.self, forKey: .categories)
        id = try? container.decode(Int.self, forKey: .id)
        if let dateString = try? container.decode(String.self, forKey: .lastCheckedOut) {
            lastCheckedOut = DateFormatter.libraryDateFormatter.date(from: dateString)
        }
        lastCheckedOutBy = try? container.decode(String.self, forKey: .lastCheckedOutBy)
        publisher = try? container.decode(String.self, forKey: .publisher)
        title = try? container.decode(String.self, forKey: .title)
        if let path = try? container.decode(String.self, forKey: .url) {
            url = LibraryPath.buildURL(withPath: path)
        } else if let id = id {
            url = LibraryPath.buildURL(withPath: "/books/\(id)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let author = author {
            try? container.encode(author, forKey: .author)
        }
        if let categories = categories {
            try? container.encode(categories, forKey: .categories)
        }
        if let id = id {
            try? container.encode(id, forKey: .id)
            try? container.encode("/books/\(id)", forKey: .url)
        }
        if let lastCheckedOut = lastCheckedOut {
            let dateString = DateFormatter.libraryDateFormatter.string(from: lastCheckedOut)
            try? container.encode(dateString, forKey: .lastCheckedOut)
        }
        if let lastCheckedOutBy = lastCheckedOutBy {
            try? container.encode(lastCheckedOutBy, forKey: .lastCheckedOutBy)
        }
        if let publisher = publisher {
            try? container.encode(publisher, forKey: .publisher)
        }
        if let title = title {
            try? container.encode(title, forKey: .title)
        }
    }

    public init(author: String?,
                categories: String?,
                id: Int?,
                lastCheckedOutBy: String?,
                publisher: String?,
                title: String?) {
        self.author = author
        self.categories = categories
        self.id = id
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
        self.title = title
        self.url = LibraryPath.buildURL(withPath: "/books/\(id ?? 0)")
    }
}
