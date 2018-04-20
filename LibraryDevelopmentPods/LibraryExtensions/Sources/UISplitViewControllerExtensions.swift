//
//  UISplitViewControllerExtensions.swift
//  LibraryExtensions
//
//  Created by Paul Jones on 4/20/18.
//

import Foundation

public extension UISplitViewController {
    public func detailViewController<T: UIViewController>() -> T? {
        if let viewController = viewControllers[safe: 1] as? T {
            return viewController
        } else if let navigationController = viewControllers[safe: 1] as? UINavigationController,
            let viewController = navigationController.viewControllers.first as? T {
            return viewController
        } else {
            return nil
        }
    }
}
