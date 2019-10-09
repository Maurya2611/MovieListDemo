//
//  MovieDetailCell.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class MovieDetailCell: BaseCell {
    static let cellHeight: CGFloat = 80
    @IBOutlet weak var viewBG: UIView! {
        didSet {
            viewBG.layer.masksToBounds = true
            viewBG.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblTittle: UILabel! {
        didSet {
            lblTittle.font = FontUtils.title2
            lblTittle.textColor = ColorUtils.charcoalGray
        }
    }
    @IBOutlet weak var lblSubTittle: UILabel! {
        didSet {
            lblSubTittle.font = FontUtils.captionOne
            lblSubTittle.textColor = ColorUtils.charcoalGray
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCellWithData(tittle: String?, subTittle: String?) {
        lblTittle.text = tittle
        lblSubTittle.text = subTittle
    }
}
