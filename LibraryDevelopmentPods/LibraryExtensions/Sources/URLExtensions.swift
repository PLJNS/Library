//
//  URLExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/18/18.
//

import Foundation

public extension URL {
    public init?(scheme: String, host: String, path: String) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        self.init(string: components.url?.absoluteString ?? "")
    }
}
