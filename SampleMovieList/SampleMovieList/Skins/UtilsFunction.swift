//
//  UtilsFunction.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation
import UIKit
struct UtilsFunction {
    static func heightOfLableAccordingContent(_ width: CGFloat,
                                       _ font: UIFont,
                                       _ text: String,
                                       numberOfLines: Int ) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
