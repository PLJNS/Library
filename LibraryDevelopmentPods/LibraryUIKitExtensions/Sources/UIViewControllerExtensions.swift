//
//  UIViewControllerExtensions.swift
//  CodableClient
//
//  Created by Paul Jones on 8/9/18.
//

import UIKit

extension UIViewController {
    public func presentAlertControllerIfError(with error: Error?) {
        guard let error = error else { return }
        let alertController = UIAlertController.alertController(withError: error)
        present(alertController, animated: true, completion: nil)
    }
}
