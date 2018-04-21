//
//  BooksViewController.swift
//  Library
//
//  Created by Paul Jones on 4/19/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import UIKit
import LibraryService
import LibraryExtensions

class BooksViewController: UIViewController {

    // MARK: - Private variables

    private var books: [Book] = []
    private var isGettingBooks: Bool = false
    private var detailViewController: BookDetailViewController? { return splitViewController?.detailViewController() }
    private let refreshControl = UIRefreshControl()

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var editBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet private var selectAllBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var deleteBarButtonItem: UIBarButtonItem!
    @IBOutlet private var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet private var deselectAllBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var flexibleSpaceBarButtonItem: UIBarButtonItem!

    // MARK: - Overrides

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshControl.addTarget(self, action: #selector(BooksViewController.attempToRequestAndReload), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        navigationController?.setToolbarHidden(true, animated: false)
        navigationItem.rightBarButtonItems = [editBarButtonItem]
        attempToRequestAndReload()
        attemptToSelectBookIfNeeded()
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
            viewController.delegate = self
        default:
            ()
        }
    }

    // MARK: - Private functions

    @objc private func attempToRequestAndReload() {
        guard isGettingBooks == false else { return }
        isGettingBooks = true
        let processId = showLoading()
        let selectedIndexPath = tableView.indexPathForSelectedRow
        let selectedBook = books[safe: selectedIndexPath?.row ?? 0]
        LibraryService.shared.getAllBooks { [weak self] (books, error) in
            guard let strongSelf = self else { return }
            strongSelf.isGettingBooks = false
            strongSelf.hideLoading(procesId: processId)
            strongSelf.presentAlertControllerIfError(with: error)
            if books != strongSelf.books {
                if UserDefaults.standard.sortNewest {
                    strongSelf.books = books?.reversed() ?? []
                } else {
                    strongSelf.books = books ?? []
                }
                strongSelf.tableView.reloadData()
                if let _ = selectedIndexPath,
                    let selectedBookId = selectedBook?.id,
                    let indexOfBook = strongSelf.books.index(where: { $0.id == selectedBookId }) {
                    strongSelf.tableView.selectRow(at: IndexPath(row: indexOfBook, section: 0),
                                                   animated: true,
                                                   scrollPosition: .none)
                } else if strongSelf.shouldSegueOnSelection {
                    strongSelf.attemptToSelectBookIfNeeded()
                }
            }
            strongSelf.editBarButtonItem.isEnabled = strongSelf.books.count > 0
            strongSelf.refreshControl.endRefreshing()
        }
    }

    private func attemptToSelectBookIfNeeded() {
        if books.count > 0 && tableView.indexPathForSelectedRow == nil {
            tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            if shouldSegueOnSelection {
                performSegue(withIdentifier: "BooksViewController_to_BookDetailViewController", sender: self)
            }
        }
    }

    private var shouldSegueOnSelection: Bool {
        return splitViewController?.displayMode == .allVisible &&
            splitViewController?.isCollapsed == false &&
            tableView.isEditing == false
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
            if tableView.indexPathsForSelectedRows?.count ?? 0 == tableView.indexPathsCount {
                let processId = showLoading()
                LibraryService.shared.deleteAll { [weak self] (error) in
                    guard let strongSelf = self else { return }
                    strongSelf.hideLoading(procesId: processId)
                    if let error = error { strongSelf.presentAlertControllerIfError(with: error); return }
                    strongSelf.tableView.setEditing(false, animated: true)
                    strongSelf.addBarButtonItem.isEnabled = true
                    strongSelf.navigationItem.setRightBarButton(strongSelf.editBarButtonItem, animated: true)
                    strongSelf.navigationController?.setToolbarHidden(true, animated: true)
                    strongSelf.attempToRequestAndReload()
                    strongSelf.detailViewController?.book = nil
                }
            } else if let bookIds = tableView.indexPathsForSelectedRows?.compactMap({ return books[$0.row].id }).compactMap({ $0 }) {
                let processId = showLoading()
                LibraryService.shared.delete(bookIds: bookIds) { [weak self] (books, errors) in
                    guard let strongSelf = self else { return }
                    strongSelf.hideLoading(procesId: processId)
                    strongSelf.presentAlertControllerIfError(with: errors?.first)
                    strongSelf.attempToRequestAndReload()
                    if let bookId = strongSelf.detailViewController?.book?.id {
                        if bookIds.contains(bookId) {
                            strongSelf.detailViewController?.book = nil
                        }
                    }
                }
            }
        default:
            assert(false)
        }

    }

    @IBAction func unwindToBooksViewController(with segue: UIStoryboardSegue) {
        attempToRequestAndReload()
    }
}

extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let bookId = books[indexPath.row].id {
            let processId = showLoading()
            LibraryService.shared.delete(bookId: bookId, completion: { [weak self] (book, error) in
                guard let strongSelf = self else { return }
                strongSelf.hideLoading(procesId: processId)
                strongSelf.presentAlertControllerIfError(with: error)
                strongSelf.attempToRequestAndReload()
                strongSelf.detailViewController?.book = nil
            })
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            deleteBarButtonItem.isEnabled = true
        } else {
            performSegue(withIdentifier: "BooksViewController_to_BookDetailViewController", sender: self)
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

extension BooksViewController: BookDetailViewControllerDelegate {
    func bookDetailViewController(viewController: BookDetailViewController, didUpdateBook: Book?) {
        attempToRequestAndReload()
    }
}
