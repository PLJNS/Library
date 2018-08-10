//
//  BookDetailViewController.swift
//  Library
//
//  Created by Paul Jones on 4/19/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import UIKit

protocol BookDetailViewControllerDelegate: class {
    func bookDetailViewController(viewController: BookDetailViewController, didUpdateBook: Book?)
}

class BookDetailViewController: UITableViewController {

    // MARK: - Public variables

    public var book: Book? { didSet { update() } }
    weak var delegate: BookDetailViewControllerDelegate?

    // MARK: - IBOutlets

    @IBOutlet private weak var bookTitleLabel: UILabel?
    @IBOutlet private weak var authorLabel: UILabel?
    @IBOutlet private weak var publisherLabel: UILabel?
    @IBOutlet private weak var tagsLabel: UILabel?
    @IBOutlet private weak var lastCheckedOutLabel: UILabel?
    @IBOutlet private weak var checkoutButton: UIButton?
    @IBOutlet private weak var shareBarButtonItem: UIBarButtonItem?
    @IBOutlet private weak var modifyBarButtonItem: UIBarButtonItem!

    // MARK: - IBActions

    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        switch sender {
        case checkoutButton:
            requestNameIfNeeded { [weak self] (name) in
                guard let strongSelf = self else { return }
                if var book = strongSelf.book {
                    book.lastCheckedOutBy = name
                    let processId = strongSelf.showLoading()
                    LibraryService.shared.update(book: book, checkingOut: true) { [weak self] (book, error) in
                        guard let strongSelf = self else { return }
                        strongSelf.hideLoading(procesId: processId)
                        strongSelf.presentAlertControllerIfError(with: error)
                        strongSelf.book = book
                        strongSelf.tableView.reloadData()
                        strongSelf.delegate?.bookDetailViewController(viewController: strongSelf, didUpdateBook: book)
                    }
                }
            }

        default:
            assert(false, "You've added a button without implementing functionality.")
        }
    }

    @IBAction func barButtonItemTouchUpInside(_ sender: UIBarButtonItem) {
        switch sender {
        case shareBarButtonItem:
            if let book = book {
                var textToShare: [Any] = [ book.description ]
                if let url = book.url {
                    textToShare.append(url)
                }
                let activityViewController = UIActivityViewController(activityItems: textToShare,
                                                                      applicationActivities: nil)
                activityViewController.popoverPresentationController?.barButtonItem = shareBarButtonItem
                present(activityViewController, animated: true, completion: nil)
            }
        case modifyBarButtonItem:
            performSegue(withIdentifier: "BookDetailViewController_to_BookEditorViewController", sender: self)
        default:
            assert(false)
        }

    }

    @IBAction func unwindToBookDetailViewController(with segue: UIStoryboardSegue) {}

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bookId = book?.id {
            update()
            LibraryService.shared.getBook(withId: bookId) { [weak self] (book, error) in
                guard let strongSelf = self else { return }
                strongSelf.presentAlertControllerIfError(with: error)
                if let book = book {
                    strongSelf.book = book
                }
                strongSelf.tableView.reloadData()
            }
        } else {
            update()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "BookDetailViewController_to_BookEditorViewController":
            guard let navigationController = segue.destination as? UINavigationController,
                let destination = navigationController.viewControllers.first as? BookEditorViewController else {
                    assert(false)
            }

            destination.mode = .update
            destination.delegate = self
            destination.book = book
        default:
            ()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // MARK: - Private functions

    private func update() {
        bookTitleLabel?.text = book?.title ?? ""
        authorLabel?.text = book?.author ?? ""
        publisherLabel?.text = book?.publisher ?? ""
        tagsLabel?.text = book?.categories ?? ""
        lastCheckedOutLabel?.text = book?.lastCheckedOutString
        shareBarButtonItem?.isEnabled = book != nil
        modifyBarButtonItem.isEnabled = book != nil
        checkoutButton?.isEnabled = book != nil
    }

    private func requestNameIfNeeded(completion: @escaping (String) -> ()) {
        if let name = UserDefaults.standard.name {
            completion(name)
        } else {
            let alertController = UIAlertController.inputAlertController(withTitle: NSLocalizedString("You found a book!", comment: ""),
                                                                         message: NSLocalizedString("What name are you using to checkout with?", comment: ""),
                                                                         placeholder: NSLocalizedString("John Doe", comment: ""),
                                                                         confirmationActionTitle: NSLocalizedString("Confirm", comment: "")) { [weak self] (name) in
                                                                            guard let strongSelf = self else { return }
                                                                            guard name != nil && !name!.isEmpty else {
                                                                                strongSelf.requestNameIfNeeded(completion: completion)
                                                                                return
                                                                            }

                                                                            if let name = name {
                                                                                UserDefaults.standard.name = name
                                                                                completion(name)
                                                                            }
            }

            present(alertController, animated: true, completion: nil)
        }
    }
}

extension BookDetailViewController: BookEditorViewControllerDelegate {
    func bookEditorViewController(viewController: BookEditorViewController, didUpdateBook book: Book?) {
        self.book = book
        delegate?.bookDetailViewController(viewController: self, didUpdateBook: book)
    }
}

