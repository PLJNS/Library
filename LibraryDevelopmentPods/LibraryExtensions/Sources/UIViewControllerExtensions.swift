//
//  UIViewControllerExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/19/18.
//

import Foundation

public extension UIViewController {
    public func presentAlertController(with error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
