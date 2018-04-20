//
//  BooksViewController.swift
//  Library
//
//  Created by Paul Jones on 4/19/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import UIKit
import LibraryClient
import LibraryExtensions

class BooksViewController: UIViewController {

    var books: [Book] = []

    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet var selectAllBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var deleteBarButtonItem: UIBarButtonItem!
    @IBOutlet var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet var deselectAllBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var flexibleSpaceBarButtonItem: UIBarButtonItem!

    // MARK: - Overrides

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
        navigationItem.rightBarButtonItems = [editBarButtonItem]
        requestAndReload {}
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.identifier {
        case .some("BooksViewController_to_BookDetailViewController"):
            guard let navigationController = segue.destination as? UINavigationController,
            let viewController = navigationController.viewControllers.first as? BookDetailViewController else {
                assert(false); return
            }

            viewController.book = books[tableView.indexPathForSelectedRow?.row ?? 0]
        default:
            ()
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !tableView.isEditing
    }

    // MARK: - Custom

    func requestAndReload(completion: @escaping () -> ()) {
        LibraryService.shared.getAllBooks { [weak self] (books, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.presentAlertController(with: error)
                return
            }
            strongSelf.books = books ?? []
            strongSelf.editBarButtonItem.isEnabled = strongSelf.books.count > 0
            strongSelf.tableView.reloadData()
        }
    }

    func contextualEditAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit", handler: { [weak self] (action, view, completion) in
            guard let strongSelf = self else { return }

        })
    }

    // MARK: - IBActions

    @IBAction func barButtonItemTouchUpInside(_ sender: UIBarButtonItem) {
        switch sender {
        case doneBarButtonItem:
            addBarButtonItem.isEnabled = true
            tableView.setEditing(false, animated: true)
            navigationItem.setRightBarButton(editBarButtonItem, animated: true)
            navigationController?.setToolbarHidden(true, animated: true)
        case editBarButtonItem:
            navigationController?.setToolbarHidden(false, animated: true)
            toolbarItems = [selectAllBarButtonItem, flexibleSpaceBarButtonItem, deleteBarButtonItem]
            deleteBarButtonItem.isEnabled = false
            selectAllBarButtonItem.isEnabled = books.count > 0
            addBarButtonItem.isEnabled = false
            tableView.setEditing(true, animated: true)
            navigationItem.rightBarButtonItems = [doneBarButtonItem]
        case selectAllBarButtonItem:
            if tableView.selectAllRows(true) {
                deleteBarButtonItem.isEnabled = true
                toolbarItems = [deselectAllBarButtonItem, flexibleSpaceBarButtonItem, deleteBarButtonItem]
            }
        case deselectAllBarButtonItem:
            if tableView.deselectAllRows(true) {
                deleteBarButtonItem.isEnabled = false
                toolbarItems = [selectAllBarButtonItem, flexibleSpaceBarButtonItem, deleteBarButtonItem]
            }
        case deleteBarButtonItem:
            LibraryService.shared.deleteAll { [weak self] (error) in
                guard let strongSelf = self else { return }
                if let error = error {
                    strongSelf.presentAlertController(with: error)
                    return
                }
                strongSelf.tableView.setEditing(false, animated: true)
                strongSelf.addBarButtonItem.isEnabled = true
                strongSelf.navigationItem.setRightBarButton(strongSelf.editBarButtonItem, animated: true)
                strongSelf.navigationController?.setToolbarHidden(true, animated: true)
                strongSelf.books = []
                strongSelf.tableView.reloadData()
            }
        default:
            assert(false)
        }

    }

    @IBAction func unwindToBooksViewController(with segue: UIStoryboardSegue) {
        requestAndReload { }
    }
}

extension BooksViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = contextualDeleteAction(forRowAt: indexPath)
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let bookId = books[indexPath.row].id {
            LibraryService.shared.delete(bookId: bookId, completion: { [weak self] (book, error) in
                guard let strongSelf = self else { return }
                strongSelf.requestAndReload { }
            })
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            deleteBarButtonItem.isEnabled = true
        }
    }
}

extension BooksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell")!
        cell.textLabel?.text = books[indexPath.row].title
        cell.detailTextLabel?.text = books[indexPath.row].author
        return cell
    }
}
