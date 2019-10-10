//
//  MainBaseViewController.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
import SnapKit
let calculateHeight: CGFloat = 44
let parallexHeight: CGFloat = 400
let screenRatio: CGFloat = 2.80
let bottomPading: CGFloat = 16

class MainBaseViewController: UIViewController {
    let padding: CGFloat = 24
    weak var headerImageView: UIView?
    var imageView = UIImageView()

    var parallaxTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHeaderView()
    }
    func setupHeaderView() {
        imageView.contentMode = .scaleToFill
        //setup blur vibrant view
        imageView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
        headerImageView = imageView
        parallaxTableView.parallaxHeader.view = headerImageView ?? imageView
        parallaxTableView.parallaxHeader.height = parallexHeight + (self.topSafeArea() * 2)
        parallaxTableView.parallaxHeader.minimumHeight = calculateHeight + self.topSafeArea()
        parallaxTableView.parallaxHeader.mode = .centerFill
        parallaxTableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            //update alpha of blur view on top of image view
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
        setUpBackButton()
    }
    func setUpBackButton() {
        let btnBack = UIButton(type: .custom)
        btnBack.frame = CGRect(x: 10, y: self.topSafeArea(),
                               width: calculateHeight,
                               height: calculateHeight)
        btnBack.setImage(#imageLiteral(resourceName: "white-back"), for: .normal)
        btnBack.tintColor = UIColor.white
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        view.addSubview(btnBack)
    }
    // MARK: - Selector
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func systemVersionLessThan(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }
}
extension UIViewController {
    typealias MethodHandler = () -> Void
    func topSafeArea() -> CGFloat {
        var safeArea: CGFloat = 20.0
        if #available(iOS 11.0, *) {
            if let padding = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                safeArea = max(padding, 20)
            }
        } else {
            safeArea = self.topLayoutGuide.length
        }
        return safeArea
    }
    func calculateBottomSafeArea() -> CGFloat {
        var bottomSafeArea: CGFloat = 20
        if #available(iOS 11.0, *) {
            bottomSafeArea = self.view.safeAreaInsets.bottom
        } else {
            bottomSafeArea = self.bottomLayoutGuide.length
        }
        return bottomSafeArea
    }
}
