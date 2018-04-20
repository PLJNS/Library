//
//  DateFormatterExtension.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/19/18.
//

import Foundation

public extension DateFormatter {
    public static let libraryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        return formatter
    }()
}
