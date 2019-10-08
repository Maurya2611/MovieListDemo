//
//  ComponentMovieListCell.swift
//  SampleMovieList
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class ComponentMovieListCell: BaseCell {
    static let cellHeight: CGFloat = 140
    @IBOutlet weak var imgPoster: UIImageView! {
        didSet {
            imgPoster.backgroundColor = .clear
            imgPoster.layer.masksToBounds = true
            imgPoster.clipsToBounds = true
            imgPoster.layer.cornerRadius = 5
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCellWithData(moviePostUrl: String?) {
        imgPoster.loadImageUsingCache(withUrl: moviePostUrl ?? "")
    }
}
