//
//  MovieDetailCell.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class MovieDetailCell: BaseCell {
    static let cellHeight: CGFloat = 180
    @IBOutlet weak var viewBG: UIView! {
        didSet {
            viewBG.layer.cornerRadius = 5
            viewBG.layer.masksToBounds = true
            viewBG.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewBG.shadowStyle(CGSize.zero, .allCorners, CGSize.zero, ColorUtils.blueGray, 0.80)
    }
    func configureCellWithData(moviePostUrl: String?) {
    }
}
