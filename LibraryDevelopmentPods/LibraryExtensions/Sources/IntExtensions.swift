//
//  IntExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/20/18.
//

import Foundation

public extension Int {
    public static var random: Int {
        return Int(UInt32.random)
    }
}
