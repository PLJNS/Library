//
//  IntExtensions.swift
//  LibraryDebug
//
//  Created by Paul Jones on 8/9/18.
//

import UIKit
import LibraryResources

public struct LibraryTheme {
    public static func applyTheme(in window: UIWindow?) {
        window?.tintColor = ColorName.tintColor.color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: FontFamily.SourceSerifPro.bold.font(size: 17)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : FontFamily.SourceSerifPro.regular.font(size: 17)], for: .normal)
    }
}

public class LRLabel: UILabel {
    public override func awakeFromNib() {
        super.awakeFromNib()
        font = FontFamily.SourceSerifPro.regular.font(size: font.pointSize)
    }
}

public class LRButton: UIButton {
    public override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.font = FontFamily.SourceSerifPro.regular.font(size: titleLabel?.font.pointSize ?? 12)
    }
}

public class LRTextField: UITextField {
    public override func awakeFromNib() {
        super.awakeFromNib()
        font = FontFamily.SourceSerifPro.regular.font(size: font?.pointSize ?? 12)
    }
}
