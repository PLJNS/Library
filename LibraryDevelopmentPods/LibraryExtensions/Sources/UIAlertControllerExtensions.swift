//
//  UIAlertControllerExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/20/18.
//

import Foundation

extension UIAlertController {
    public static func alertController(withError error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""),
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }

    public static func confirmationAlertController(withTitle title: String,
                                                   message: String,
                                                   confirmationActionTitle: String,
                                                   cancelActionTitle: String,
                                                   with completion: @escaping (_ confirmed: Bool) -> ()) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: confirmationActionTitle,
                                                style: .destructive,
                                                handler: { (_) in
                                                    completion(true)
        }))
        alertController.addAction(UIAlertAction(title: cancelActionTitle,
                                                style: .cancel,
                                                handler: { (_) in
                                                    completion(false)
        }))
        return alertController
    }

    public static func inputAlertController(withTitle title: String,
                                            message: String,
                                            placeholder: String?,
                                            confirmationActionTitle: String?,
                                            completion: @escaping (_ input: String?) -> ()) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = placeholder
            textField.autocapitalizationType = .words
        })
        let confirmAction = UIAlertAction(title: confirmationActionTitle, style: .default, handler: {(_ action: UIAlertAction) -> Void in
            completion(alertController.textFields?[0].text)
        })
        alertController.addAction(confirmAction)
        return alertController
    }
}
