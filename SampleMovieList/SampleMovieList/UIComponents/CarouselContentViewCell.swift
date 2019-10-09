//
//  CarouselContentViewCell.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class CarouselContentViewCell: BaseCell {
    static let cellHeight: CGFloat = 250
    lazy var innerContainerView: CDCarouselBGView = {
        let view = CDCarouselBGView.viewFromNib()
        view.backgroundColor = .clear
        return view
    }()
    func loadCellWithData(imageURL: String?) {
        innerContainerView.imgPoster.loadImageUsingCache(withUrl: imageURL ?? "")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(innerContainerView)
        
    }
}
