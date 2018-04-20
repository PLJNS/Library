//
//  LibraryClient.swift
//  LibraryClient
//
//  Created by Paul Jones on 4/18/18.
//

import Foundation
import LibraryExtensions

internal struct LibraryClient {
    private static let scheme = "https"
    internal static let host = "prolific-interview.herokuapp.com"
    internal static let id = "5acb830d057b610009a97cb8"

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let session: URLSession

    internal init(withSession session: URLSession) {
        self.session = session
    }

    internal enum Path {
        case getAll
        case add(book: Book)
        case update(book: Book)
        case get(bookId: Int)
        case delete(bookId: Int)
        case deleteAll

        internal var url: URL? {
            switch self {
            case .getAll, .add(_):
                return buildURL(withPath: "/books/")
            case .get(let bookId), .delete(let bookId):
                return buildURL(withPath: "/books/\(bookId)/")
            case .update(let book):
                if let bookId = book.id { return buildURL(withPath: "/books/\(bookId)/") }
                else { return nil }
            case .deleteAll:
                return buildURL(withPath: "/clean/")
            }
        }

        internal var method: HTTPMethod {
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
    }

    internal static func buildURL(withPath path: String) -> URL? {
        return URL(scheme: LibraryClient.scheme,
                   host: LibraryClient.host,
                   path: "/\(LibraryClient.id)\(path)")
    }

    @discardableResult internal func load<T : Codable>(_ path: Path, completion: @escaping (_ response: T?, _ error: Error?) -> Void) -> URLSessionDataTask? {
        guard let url = path.url else { DispatchQueue.main.async { completion(nil, nil) }; return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = path.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch path {
        case .add(let book), .update(let book):
            urlRequest.httpBody = try? encoder.encode(book)
        default:
            ()
        }
        let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else { DispatchQueue.main.async { completion(nil, error) }; return }
            guard let response = try? self.decoder.decode(T.self, from: data) else { DispatchQueue.main.async { completion(nil, error) }; return }
            DispatchQueue.main.async { completion(response, error) }
        })
        DispatchQueue.global().async { task.resume() }
        return task
    }
}
