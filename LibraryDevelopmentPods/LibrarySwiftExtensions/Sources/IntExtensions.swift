//
//  IntExtensions.swift
//  LibraryDebug
//
//  Created by Paul Jones on 8/9/18.
//

import Foundation

public extension Int {
    public static var random: Int {
        return Int(UInt32.random)
    }
}
