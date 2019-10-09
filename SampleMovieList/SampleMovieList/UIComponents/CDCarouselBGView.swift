//
//  CDCarouselBgView.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import UIKit
import Foundation

public class CDCarouselBGView: BaseView {
    static public func viewFromNib() -> CDCarouselBGView {
        return (nib.instantiate(withOwner: nil, options: nil).first as? CDCarouselBGView)!
    }
    public var backgroundCDColor: UIColor? = ColorUtils.white
    public var shadowCDColor: UIColor?
    @IBOutlet weak var imgPoster: UIImageView!
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview != nil {
            self.snp.makeConstraints { (make) -> Void in
                make.edges.equalToSuperview()
            }
        }
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.shadowStyle(CGSize(width: 34, height: 34), .bottomRight, ColorUtils.lightGreyBlue, 1.0)
        self.layer.cornerRadius = 5
        imgPoster.layer.cornerRadius = 6
        if #available(iOS 11.0, *) {
          imgPoster.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        imgPoster.roundCorners(.bottomRight, radius: CGSize(width: 34, height: 34))
    }
}
