//
//  BookDetailViewController.swift
//  Library
//
//  Created by Paul Jones on 4/19/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import UIKit
import LibraryClient

class BookDetailViewController: UIViewController {

    var book: Book?

    // MARK: - IBOutlets

    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var lastCheckedOutLabel: UILabel!
    @IBOutlet private weak var checkoutButton: UIButton!

    // MARK: - IBActions

    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        switch sender {
        case checkoutButton:
            ()
        default:
            assert(false, "You've added a button without implementing functionality.")
        }
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitleLabel.text = book?.title ?? ""
        authorLabel.text = book?.author ?? ""
        publisherLabel.text = book?.publisher ?? ""
        tagsLabel.text = book?.categories ?? ""
        lastCheckedOutLabel.text = book?.lastCheckedOutBy ?? ""
    }
}

