//
//  StringExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/19/18.
//

import Foundation

public extension String {
    public var nilIfEmpty: String? {
        return isEmpty ? nil : self
    }
}
