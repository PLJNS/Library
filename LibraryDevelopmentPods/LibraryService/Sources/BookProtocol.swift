//
//  BookProtocol.swift
//  LibraryService
//
//  Created by Paul Jones on 4/21/18.
//

import Foundation

public protocol BookProtocol {
    var author: String? { get }
    var categories: String? { get }
    var id: Int? { get }
    var lastCheckedOut: Date? { get }
    var lastCheckedOutBy: String? { get }
    var publisher: String? { get }
    var title: String? { get }
    var url: URL? { get }
    var lastCheckedOutString: String? { get }
}
