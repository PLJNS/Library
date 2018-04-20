//
//  CollectionExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/20/18.
//

import Foundation

public extension Collection {
    public subscript (safe index: Index) -> Element? {
        if indices.contains(index) {
            return self[index]
        } else {
            return nil
        }
    }
}
