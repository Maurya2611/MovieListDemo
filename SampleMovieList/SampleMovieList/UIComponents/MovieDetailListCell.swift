//
//  MovieDetailListCell.swift
//  SampleMovieList
//
//  Created by Chandresh on 10/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class MovieDetailListCell: BaseReusableTableView {
    static let cellHeight: CGFloat = 70
    @IBOutlet weak var lblTittle: UILabel! {
        didSet {
            lblTittle.font = FontUtils.title3
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
