import Foundation
import UIKit

protocol FontProtocol {
    static var CMFontFamily: String { get }
    static func CMBaseFont(family: String, size: CGFloat, weight: UIFont.Weight) -> UIFont
}
struct FontUtils: FontProtocol {
    static let standardScreenWidth: CGFloat = 375.0
    static let CMFontFamily: String = "Roboto"
    //To Do Better Way......
    static func CMBaseFont(family: String = CMFontFamily,
                           size: CGFloat,
                           weight: UIFont.Weight = UIFont.Weight.regular ) -> UIFont {
        let fontformat = "%@-%@"
        var fontName = "Roboto-Regular"
        switch weight {
        case UIFont.Weight.regular:
            fontName = String(format: fontformat, family, "Regular")
        case UIFont.Weight.light:
            fontName = String(format: fontformat, family, "Light")
        case UIFont.Weight.medium:
            fontName = String(format: fontformat, family, "Medium")
        case UIFont.Weight.bold:
            fontName = String(format: fontformat, family, "Bold")
        case UIFont.Weight.thin:
            fontName = String(format: fontformat, family, "Thin")
        default:
            break
        }
        var perferSize = size
        if UIScreen.main.bounds.width < FontUtils.standardScreenWidth {
            perferSize = (size / FontUtils.standardScreenWidth) * UIScreen.main.bounds.width
            perferSize.round(.toNearestOrAwayFromZero)
        }
        guard let font = UIFont(name: fontName, size: perferSize) else {
            return UIFont.systemFont(ofSize: perferSize, weight: weight)
        }
        return font
    }
    static var title0: UIFont {
        return CMBaseFont(size: 34.0, weight: .bold)
    }
    static var title1: UIFont {
        return CMBaseFont(size: 26.0, weight: .bold) //done
    }
    static var title2: UIFont {
        return CMBaseFont(size: 22.0, weight: .bold) //done
    }
    static var title3: UIFont {
        return CMBaseFont(size: 20.0, weight: .medium)
    }
    static var headline: UIFont {
        return CMBaseFont(size: 17.0, weight: .medium)
    }
    static var body: UIFont {
        return CMBaseFont(size: 16.0, weight: .regular)
    }
    static var bodyMedium: UIFont {
        return CMBaseFont(size: 16.0, weight: .medium)
    }
    static var subHead: UIFont {
        return CMBaseFont(size: 15.0, weight: .regular)
    }
    static var footNote: UIFont {
        return CMBaseFont(size: 13.0, weight: .regular)
    }
    static var footNoteMedium: UIFont {
        return CMBaseFont(size: 13.0, weight: .medium)
    }
    static var caption: UIFont {
        return CMBaseFont(size: 12.0, weight: .regular)
    }
    static var captionOne: UIFont {
        return CMBaseFont(size: 14.0, weight: .light)
    }
    static var label: UIFont {
        return CMBaseFont(size: 11.0, weight: .regular)
    }
}
