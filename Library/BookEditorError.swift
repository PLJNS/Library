//
//  BookEditorError.swift
//  Library
//
//  Created by Paul Jones on 4/20/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import Foundation

class BookEditorError: NSObject, LocalizedError {
    var reason: String = ""

    init(reason: String) {
        self.reason = reason
    }

    override var description: String {
        get {
            return "Add book error: \(reason)"
        }
    }

    var errorDescription: String? {
        get {
            return self.description
        }
    }
}
