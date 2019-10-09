//
//  ComponentMovieListCell.swift
//  SampleMovieList
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class ComponentMovieListCell: BaseCell {
    static let cellHeight: CGFloat = 180
    @IBOutlet weak var viewBG: UIView! {
        didSet {
            viewBG.layer.cornerRadius = 5
            viewBG.layer.masksToBounds = true
            viewBG.clipsToBounds = true
        }
    }
    @IBOutlet weak var imgPoster: UIImageView! {
        didSet {
            imgPoster.backgroundColor = .clear
            imgPoster.layer.cornerRadius = 5
            imgPoster.layer.masksToBounds = true
            imgPoster.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewBG.shadowStyle(CGSize.zero, .allCorners, ColorUtils.blueGray, 0.70)
    }
    func configureCellWithData(moviePostUrl: String?) {
        imgPoster.loadImageUsingCache(withUrl: moviePostUrl ?? "")
    }
}
