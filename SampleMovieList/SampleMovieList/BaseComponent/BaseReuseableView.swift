//
//  BaseReuseableHeaderView.swift
//  BaseComponent
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import Foundation
import UIKit
open class BaseReuseableView: UICollectionReusableView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    public static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: nil)
    }
}
