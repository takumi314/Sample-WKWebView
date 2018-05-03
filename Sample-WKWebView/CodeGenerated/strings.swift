// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Alert {
    /// Alert Message
    static let message = L10n.tr("Localizable", "alert.message")
    /// Alert Title
    static let title = L10n.tr("Localizable", "alert.title")
  }

  enum Alertaction {
    /// Cancel
    static let cancel = L10n.tr("Localizable", "alertAction.cancel")
    /// Alert Message
    static let message = L10n.tr("Localizable", "alertAction.message")
    /// OK
    static let ok = L10n.tr("Localizable", "alertAction.ok")
    /// Alert Title
    static let title = L10n.tr("Localizable", "alertAction.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
