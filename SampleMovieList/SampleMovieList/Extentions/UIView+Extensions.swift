import UIKit
import Foundation
// MARK: - Properties
public extension UIView {
    /// Size of view.
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    /// Width of view.
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    /// Height of view.
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
}
// MARK: - Methods
public extension UIView {
    typealias Configuration = (UIView) -> Swift.Void
    func config(configurate: Configuration?) {
        configurate?(self)
    }
    /// Set some or all corners radiuses of view.
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGSize) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radius)
        let mask = CAShapeLayer()
        mask.path = maskPath.cgPath
        layer.mask = mask
    }
    func shadowStyle(_ radius: CGSize,
                     _ corners: UIRectCorner,
                     _ shadowColor: UIColor,
                     _ shadowOpacity: Float) {
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.roundCorners(corners, radius: radius)
    }
}
