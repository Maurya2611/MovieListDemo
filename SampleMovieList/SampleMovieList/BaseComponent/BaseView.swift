//
//  BaseView.swift
//  BaseComponent
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import UIKit
open class  BaseView: UIView {
    public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}
