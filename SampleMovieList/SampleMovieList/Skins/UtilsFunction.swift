//
//  UtilsFunction.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation
import UIKit
import RSLoadingView

struct UtilsFunction {
    static var loadingView = RSLoadingView(effectType: RSLoadingView.Effect.spinAlone)

    static func heightOfLableAccordingContent(_ width: CGFloat,
                                              _ font: UIFont,
                                              _ text: String, numberOfLines: Int ) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    static func showOnLoader() {
        loadingView.shouldTapToDismiss = true
        loadingView.variantKey = "inAndOut"
        loadingView.speedFactor = 1.0
        loadingView.lifeSpanFactor = 2.0
        loadingView.mainColor = UIColor.green
        loadingView.sizeInContainer = CGSize(width: 100, height: 100)
        loadingView.showOnKeyWindow()
    }
    static func hideOffLoader() {
        self.loadingView.hide()
        self.loadingView.removeFromSuperview()
    }
    static func getDatefromString(strDate: String?) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        var releaseDate = strDate ?? ""
        if let date = dateFormatterGet.date(from: strDate ?? "") {
            releaseDate = dateFormatterPrint.string(from: date)
        }
        return releaseDate
    }
}
