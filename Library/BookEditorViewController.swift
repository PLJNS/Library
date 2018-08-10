//
//  AddBookViewController.swift
//  Library
//
//  Created by Paul Jones on 4/19/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import UIKit
import LibrarySwiftExtensions

protocol BookEditorViewControllerDelegate: class {
    func bookEditorViewController(viewController: BookEditorViewController, didUpdateBook book: Book?)
}

class BookEditorViewController: UITableViewController {

    // MARK: - Models

    class Error: NSObject, LocalizedError {
        var reason: String = ""
        init(reason: String) { self.reason = reason }
        override var description: String { return reason }
        var errorDescription: String? { return description }
    }

    enum Mode {
        case update
        case add
        var unwindSegueIdentifier: String {
            switch self {
            case .update: return "BookEditorViewController_to_BookDetailViewController"
            case .add: return "BookEditorViewController_to_BooksViewController"
            }
        }
    }

    // MARK: - Public variables

    public var mode: Mode = .add
    public weak var delegate: BookEditorViewControllerDelegate?
    public var book: Book? {
        get {
            let title = titleTextField?.text?.nilIfEmpty
            let author = authorTextField?.text?.nilIfEmpty
            let publisher = publisherTextField?.text?.nilIfEmpty
            let categories = categoriesTextField?.text?.nilIfEmpty
            return Book(author: author,
                        categories: categories,
                        id: bookStorage?.id,
                        lastCheckedOutBy: bookStorage?.lastCheckedOutBy,
                        publisher: publisher,
                        title: title)
        }
        set {
            bookStorage = newValue
            updateFromBook()
        }
    }

    // MARK: - Private variables

    private var bookStorage: Book?
    private var somethingChanged: Bool = false

    // MARK: - IBOutlets

    @IBOutlet private weak var titleTextField: UITextField?
    @IBOutlet private weak var authorTextField: UITextField?
    @IBOutlet private weak var publisherTextField: UITextField?
    @IBOutlet private weak var categoriesTextField: UITextField?
    @IBOutlet private weak var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var cancelBarButtonItem: UIBarButtonItem!

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        updateFromBook()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // MARK: - Custom

    private func dismiss() {
        performSegue(withIdentifier: mode.unwindSegueIdentifier, sender: self)
    }

    private func updateFromBook() {
        titleTextField?.text = bookStorage?.title
        authorTextField?.text = bookStorage?.author
        publisherTextField?.text = bookStorage?.publisher
        categoriesTextField?.text = bookStorage?.categories
    }

    private func attemptToSubmit(completion: @escaping (Book?, Swift.Error?) -> ()) {
        guard let _ = titleTextField?.text?.nilIfEmpty else { completion(nil, Error(reason: NSLocalizedString("Please add a title.", comment: ""))); return }
        guard let _ = authorTextField?.text?.nilIfEmpty else { completion(nil, Error(reason: NSLocalizedString("Please add an author.", comment: ""))); return }
        guard let theBook = book else { completion(nil, Error(reason: NSLocalizedString("Unrecoverable error. Panic.", comment: ""))); return }

        let processId = showLoading()
        switch mode {
        case .update:
            LibraryService.shared.update(book: theBook) { [weak self] (book, error) in
                guard let strongSelf = self else { return }
                strongSelf.hideLoading(procesId: processId)
                strongSelf.presentAlertControllerIfError(with: error)
                strongSelf.delegate?.bookEditorViewController(viewController: strongSelf, didUpdateBook: book)
                completion(book, error)
            }
        case .add:
            LibraryService.shared.add(book: theBook) { [weak self] (book, error) in
                guard let strongSelf = self else { return }
                strongSelf.hideLoading(procesId: processId)
                strongSelf.presentAlertControllerIfError(with: error)
                completion(book, error)
            }
        }

    }

    // MARK: - IBActions

    @IBAction func barButtonItemTouchUpInside(_ sender: UIBarButtonItem) {
        switch sender {
        case doneBarButtonItem:
            attemptToSubmit { [weak self] (book, error) in
                guard let strongSelf = self else { return }
                guard error == nil else {
                    strongSelf.presentAlertControllerIfError(with: error)
                    return
                }

                strongSelf.dismiss()
            }
        case cancelBarButtonItem:
            if somethingChanged {
                let alertController = UIAlertController.confirmationAlertController(withTitle: NSLocalizedString("Are you sure?", comment: ""),
                                                                                    message: NSLocalizedString("Any unsaved changes will be lost.", comment: ""),
                                                                                    confirmationActionTitle: NSLocalizedString("OK", comment: ""),
                                                                                    cancelActionTitle: NSLocalizedString("Cancel", comment: ""),
                                                                                    with: { [weak self] (confirmed) in
                                                                                        guard let strongSelf = self else { return }
                                                                                        if confirmed {
                                                                                            strongSelf.dismiss()
                                                                                        }
                })
                present(alertController, animated: true, completion: nil)
            } else {
                dismiss()
            }
        default:
            assert(false)
        }
    }
}

extension BookEditorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        somethingChanged = true
        doneBarButtonItem.isEnabled = true
        return true
    }
}
