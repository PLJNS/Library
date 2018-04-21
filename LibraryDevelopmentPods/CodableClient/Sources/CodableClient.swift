//
//  LibraryClient.swift
//  LibraryClient
//
//  Created by Paul Jones on 4/18/18.
//

import Foundation
import LibraryExtensions

public struct CodableClient {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let session: URLSession

    public init(withSession session: URLSession) {
        self.session = session
    }

    @discardableResult public func load<T : Codable>(_ path: URLConvertible, completion: @escaping (_ response: T?, _ error: Error?) -> Void) -> URLSessionDataTask? {
        guard let url = path.url else { DispatchQueue.main.async { completion(nil, nil) }; return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = path.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let body = path.httpBody {
            urlRequest.httpBody = try? encoder.encode(body as? T)
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
