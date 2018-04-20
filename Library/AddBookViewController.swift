//
//  AddBookViewController.swift
//  Library
//
//  Created by Paul Jones on 4/19/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import UIKit
import LibraryClient
import LibraryExtensions

class AddBookError: NSObject, LocalizedError {
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

class AddBookViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    // MARK: - Custom

    func attemptToSubmit(completion: @escaping (Book?, Error?) -> ()) {
        guard let title = titleTextField.text?.nilIfEmpty else {
            completion(nil, AddBookError(reason: "Please add a title."))
            return
        }
        guard let author = authorTextField.text?.nilIfEmpty else {
            completion(nil, AddBookError(reason: "Please add an author."))
            return
        }
        guard let publisher = publisherTextField.text?.nilIfEmpty else {
            completion(nil, AddBookError(reason: "Please add a publisher."))
            return
        }
        guard let categories = categoriesTextField.text?.nilIfEmpty else {
            completion(nil, AddBookError(reason: "Please add a categories."))
            return
        }

        let book = Book(author: author,
                        categories: categories,
                        id: nil,
                        lastCheckedOut: nil,
                        lastCheckedOutBy: nil,
                        publisher: publisher,
                        title: title,
                        url: nil)

        LibraryService.shared.add(book: book, completion: completion)
    }

    // MARK: - IBActions

    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        switch sender {
        case submitButton:
            attemptToSubmit { [weak self] (book, error) in
                guard let strongSelf = self else { return }
                if let error = error {
                    strongSelf.presentAlertController(with: error)
                } else {
                    strongSelf.performSegue(withIdentifier: "AddBookViewController_to_BooksViewController",
                                            sender: strongSelf)
                }
            }
        default:
            ()
        }
    }
}
