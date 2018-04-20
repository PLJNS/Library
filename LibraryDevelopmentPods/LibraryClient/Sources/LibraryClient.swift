//
//  LibraryClient.swift
//  LibraryClient
//
//  Created by Paul Jones on 4/18/18.
//

import Foundation
import LibraryExtensions

public struct LibraryClient {
    private static let scheme = "https"
    static let host = "prolific-interview.herokuapp.com"
    static let id = "5acb830d057b610009a97cb8"

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let session: URLSession

    public init(withSession session: URLSession) {
        self.session = session
    }

    public enum Path {
        case getAll
        case add(book: Book)
        case get(bookId: Int)
        case update(book: Book)
        case delete(book: Book)
        case deleteAll

        var url: URL? {
            switch self {
            case .getAll, .add(_):
                return URL(scheme: scheme, host: host, path: "/\(id)/books")
            case .get(let bookId):
                return URL(scheme: scheme, host: host, path: "/\(id)/books/\(bookId)")
            case .update(let book), .delete(let book):
                if let bookId = book.id {
                    return URL(scheme: scheme, host: host, path: "/\(id)/books/\(bookId)")
                } else {
                    return nil
                }
            case .deleteAll:
                return URL(scheme: scheme, host: host, path: "/\(id)/books/")
            }
        }

        var method: HTTPMethod {
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

    @discardableResult func load<T : Codable>(_ path: Path, completionHandler: @escaping (_ response: T?, _ error: Error?) -> Void) -> URLSessionDataTask? {
        guard let url = path.url else { DispatchQueue.main.async { completionHandler(nil, nil) }; return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = path.method.rawValue
        switch path {
        case .add(let book), .update(let book):
            urlRequest.httpBody = try? encoder.encode(book)
        default:
            ()
        }
        let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else { DispatchQueue.main.async { completionHandler(nil, error) }; return }
            guard let response = try? self.decoder.decode(T.self, from: data) else { DispatchQueue.main.async { completionHandler(nil, error) }; return }
            DispatchQueue.main.async { completionHandler(response, error) }
        })
        DispatchQueue.global().async { task.resume() }
        return task
    }
}

