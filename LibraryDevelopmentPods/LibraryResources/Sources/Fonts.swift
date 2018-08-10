// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  public typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  public typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  public func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  public func register() {
    guard let url = url else { return }
    var errorRef: Unmanaged<CFError>?
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, &errorRef)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

public extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable identifier_name line_length type_body_length
public enum FontFamily {
  public enum SourceCodePro {
    public static let black = FontConvertible(name: "SourceCodePro-Black", family: "Source Code Pro", path: "SourceCodePro-Black.ttf")
    public static let bold = FontConvertible(name: "SourceCodePro-Bold", family: "Source Code Pro", path: "SourceCodePro-Bold.ttf")
    public static let extraLight = FontConvertible(name: "SourceCodePro-ExtraLight", family: "Source Code Pro", path: "SourceCodePro-ExtraLight.ttf")
    public static let light = FontConvertible(name: "SourceCodePro-Light", family: "Source Code Pro", path: "SourceCodePro-Light.ttf")
    public static let medium = FontConvertible(name: "SourceCodePro-Medium", family: "Source Code Pro", path: "SourceCodePro-Medium.ttf")
    public static let regular = FontConvertible(name: "SourceCodePro-Regular", family: "Source Code Pro", path: "SourceCodePro-Regular.ttf")
    public static let semibold = FontConvertible(name: "SourceCodePro-Semibold", family: "Source Code Pro", path: "SourceCodePro-Semibold.ttf")
  }
  public enum SourceSansPro {
    public static let black = FontConvertible(name: "SourceSansPro-Black", family: "Source Sans Pro", path: "SourceSansPro-Black.ttf")
    public static let blackItalic = FontConvertible(name: "SourceSansPro-BlackItalic", family: "Source Sans Pro", path: "SourceSansPro-BlackItalic.ttf")
    public static let bold = FontConvertible(name: "SourceSansPro-Bold", family: "Source Sans Pro", path: "SourceSansPro-Bold.ttf")
    public static let boldItalic = FontConvertible(name: "SourceSansPro-BoldItalic", family: "Source Sans Pro", path: "SourceSansPro-BoldItalic.ttf")
    public static let extraLight = FontConvertible(name: "SourceSansPro-ExtraLight", family: "Source Sans Pro", path: "SourceSansPro-ExtraLight.ttf")
    public static let extraLightItalic = FontConvertible(name: "SourceSansPro-ExtraLightItalic", family: "Source Sans Pro", path: "SourceSansPro-ExtraLightItalic.ttf")
    public static let italic = FontConvertible(name: "SourceSansPro-Italic", family: "Source Sans Pro", path: "SourceSansPro-Italic.ttf")
    public static let light = FontConvertible(name: "SourceSansPro-Light", family: "Source Sans Pro", path: "SourceSansPro-Light.ttf")
    public static let lightItalic = FontConvertible(name: "SourceSansPro-LightItalic", family: "Source Sans Pro", path: "SourceSansPro-LightItalic.ttf")
    public static let regular = FontConvertible(name: "SourceSansPro-Regular", family: "Source Sans Pro", path: "SourceSansPro-Regular.ttf")
    public static let semiBold = FontConvertible(name: "SourceSansPro-SemiBold", family: "Source Sans Pro", path: "SourceSansPro-SemiBold.ttf")
    public static let semiBoldItalic = FontConvertible(name: "SourceSansPro-SemiBoldItalic", family: "Source Sans Pro", path: "SourceSansPro-SemiBoldItalic.ttf")
  }
  public enum SourceSerifPro {
    public static let bold = FontConvertible(name: "SourceSerifPro-Bold", family: "Source Serif Pro", path: "SourceSerifPro-Bold.ttf")
    public static let regular = FontConvertible(name: "SourceSerifPro-Regular", family: "Source Serif Pro", path: "SourceSerifPro-Regular.ttf")
    public static let semibold = FontConvertible(name: "SourceSerifPro-Semibold", family: "Source Serif Pro", path: "SourceSerifPro-Semibold.ttf")
  }
}
// swiftlint:enable identifier_name line_length type_body_length

private final class BundleToken {}
