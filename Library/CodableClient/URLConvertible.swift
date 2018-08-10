//
//  URLConvertible.swift
//  LibraryService
//
//  Created by Paul Jones on 4/21/18.
//

import Foundation

public protocol URLConvertible {
    var url: URL? { get }
    var method: HTTPMethod { get }
    var httpBody: Codable? { get }
}
