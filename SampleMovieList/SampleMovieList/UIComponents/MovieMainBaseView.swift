//
//  MovieMainBaseView.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class MovieMainBaseView: BaseView {
    static public func viewFromNib() -> MovieMainBaseView {
        return (nib.instantiate(withOwner: nil, options: nil).first as? MovieMainBaseView)! 
    }
    @IBOutlet weak var imgPoster: UIImageView! {
        didSet {
            imgPoster.layer.masksToBounds = true
            imgPoster.clipsToBounds = true
        }
    }
}
