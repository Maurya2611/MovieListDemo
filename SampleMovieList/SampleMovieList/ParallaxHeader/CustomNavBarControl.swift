//
//  ComponentMovieListCell.swift
//  CustomNavBarControl
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
import Foundation
import UIKit
@IBDesignable
class CustomNavBarControl: BaseView {
    static func viewFromNib() -> CustomNavBarControl {
        return (nib.instantiate(withOwner: nil, options: nil).first as? CustomNavBarControl)!
    }
    @IBOutlet weak var navigationBar: UIToolbar! {
        didSet {
            navigationBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
            navigationBar.setShadowImage(UIImage(), forToolbarPosition: .any)
            navigationBar.isTranslucent = true
            navigationBar.backgroundColor = .clear
        }
    }
    @IBOutlet weak var navigationBarTitle: UIBarButtonItem! {
        didSet {
            navigationBarTitle.setTitleTextAttributes([
                NSAttributedString.Key.font: FontUtils.headline], for: .normal)
            navigationBarTitle.setTitleTextAttributes([
                NSAttributedString.Key.font: FontUtils.headline], for: .highlighted)
        }
    }
    @IBOutlet weak var navigationLeftButton: UIBarButtonItem! {
        didSet {
            navigationLeftButton.setTitleTextAttributes([
                NSAttributedString.Key.font: FontUtils.bodyMedium], for: .normal)
            navigationLeftButton.setTitleTextAttributes([
                NSAttributedString.Key.font: FontUtils.bodyMedium], for: .highlighted)
        }
    }
    @IBOutlet weak var navigationRightButton: UIBarButtonItem! {
        didSet {
            navigationRightButton.setTitleTextAttributes([
                NSAttributedString.Key.font: FontUtils.bodyMedium,
                NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            navigationRightButton.setTitleTextAttributes([
                NSAttributedString.Key.font: FontUtils.bodyMedium,
                NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
        }
    }
}
