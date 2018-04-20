//
//  UITableViewExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/19/18.
//

import Foundation

public extension UITableView {
    @discardableResult public func selectAllRows(_ animated: Bool) -> Bool {
        var selectedRow = false
        for section in 0..<numberOfSections {
            for row in 0..<numberOfRows(inSection: section) {
                selectRow(at: IndexPath(row: row, section: section), animated: animated, scrollPosition: .none)
                selectedRow = true
            }
        }
        return selectedRow
    }

    @discardableResult public func deselectAllRows(_ animated: Bool) -> Bool {
        var deselectedRow = false
        for section in 0..<numberOfSections {
            for row in 0..<numberOfRows(inSection: section) {
                deselectRow(at: IndexPath(row: row, section: section), animated: animated)
                deselectedRow = true
            }
        }
        return deselectedRow
    }

    public var indexPathsCount: Int {
        var count = 0
        for section in 0..<numberOfSections {
            for _ in 0..<numberOfRows(inSection: section) {
                count += 1
            }
        }
        return count
    }
}
