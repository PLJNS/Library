//
//  ViewController.swift
//  Library for Mac
//
//  Created by Paul Jones on 8/9/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import Cocoa
import LibraryService

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        LibraryService.shared.getAllBooks { (books, error) in
            self.textView.string = books?.description ?? ""
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

