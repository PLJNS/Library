// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
public enum L10n {
  /// Please add an author.
  public static let addAuthor = L10n.tr("Localizable", "ADD_AUTHOR")
  /// Please add categories.
  public static let addCategories = L10n.tr("Localizable", "ADD_CATEGORIES")
  /// Please add a publisher.
  public static let addPublisher = L10n.tr("Localizable", "ADD_PUBLISHER")
  /// Please add a title.
  public static let addTitle = L10n.tr("Localizable", "ADD_TITLE")
  /// Are you sure?
  public static let areYouSure = L10n.tr("Localizable", "ARE_YOU_SURE")
  /// Cancel
  public static let cancel = L10n.tr("Localizable", "CANCEL")
  /// Confirm
  public static let confirm = L10n.tr("Localizable", "CONFIRM")
  /// Error
  public static let error = L10n.tr("Localizable", "ERROR")
  /// John Doe
  public static let exampleName = L10n.tr("Localizable", "EXAMPLE_NAME")
  /// What name are you using to checkout with?
  public static let nameAlertBody = L10n.tr("Localizable", "NAME_ALERT_BODY")
  /// You found a book!
  public static let nameAlertTitle = L10n.tr("Localizable", "NAME_ALERT_TITLE")
  /// OK
  public static let ok = L10n.tr("Localizable", "OK")
  /// Unrecoverable error. Panic.
  public static let unrecoverableError = L10n.tr("Localizable", "UNRECOVERABLE_ERROR")
  /// Any unsaved changes will be lost.
  public static let unsavedChangesWillBeLost = L10n.tr("Localizable", "UNSAVED_CHANGES_WILL_BE_LOST")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
