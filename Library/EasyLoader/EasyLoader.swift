//
//  UIViewControllerExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/19/18.
//

import UIKit

public extension UIViewController {
    public func showLoading(style: UIActivityIndicatorViewStyle = .gray) -> Int {
        let processId = Int.random
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: style)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.tag = processId
        activityIndicatorView.center = view.center
        activityIndicatorView.alpha = 0
        activityIndicatorView.startAnimating()

        view.isUserInteractionEnabled = false
        view.addSubview(activityIndicatorView)

        UIView.animate(withDuration: 0.25) {
            activityIndicatorView.alpha = 1
        }

        return processId
    }

    public func hideLoading(procesId: Int) {
        view.isUserInteractionEnabled = true
        if let activityIndicatorView = view.viewWithTag(procesId) {
            UIView.animate(withDuration: 0.25, animations: {
                activityIndicatorView.alpha = 0
            }) { (_) in
                activityIndicatorView.removeFromSuperview()
            }
        }

    }
}
