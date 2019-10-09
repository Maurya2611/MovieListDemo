//
//  MainBaseViewController.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
import SnapKit
enum NavigationType {
    case `default`
    case main
}
let segementHeight: CGFloat = 40
let parallexHeight: CGFloat = 400
let screenRatio: CGFloat = 2.80
let bottomPading: CGFloat = 16

class MainBaseViewController: UIViewController {
    let padding: CGFloat = 24
    var navigationType: NavigationType {
        return .default
    }
    lazy var navigationView: MovieMainBaseView = {
        let navBackGroundView = MovieMainBaseView.viewFromNib()
        return navBackGroundView
    }()
    lazy var navigationControl: CustomNavBarControl = {
        let nav = CustomNavBarControl.viewFromNib()
        nav.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: segementHeight + self.topSafeArea())
        return nav
    }()
    
    lazy var navigationLargeTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        label.font = FontUtils.title2
        return label
    }()
    lazy var navSubTittle: UILabel = {
        let label = UILabel(frame: CGRect(x: self.padding, y: 0 ,
                                          width: UIScreen.main.bounds.width - (self.padding * 2),
                                          height: segementHeight))
        label.font = FontUtils.footNoteMedium
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    var parallaxCollectionView: UICollectionView! {
        didSet {
            if #available(iOS 11.0, *) {} else {
                parallaxCollectionView.snp.updateConstraints { make in
                    make.top.equalTo(-20)
                }
            }
        }
    }
    override var title: String? {
        didSet {
            self.navigationControl.navigationBarTitle.title = title
            self.navigationLargeTitleLabel.text = title
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.font: FontUtils.title0]
        }
    }
    fileprivate func setBarButtonStyle() {
        self.navigationControl.navigationRightButton.setTitleTextAttributes([
            NSAttributedString.Key.font: FontUtils.footNote,
            NSAttributedString.Key.foregroundColor: ColorUtils.white], for: .normal)
        self.navigationControl.navigationRightButton.setTitleTextAttributes([
            NSAttributedString.Key.font: FontUtils.footNote,
            NSAttributedString.Key.foregroundColor: ColorUtils.white], for: .highlighted)
    }
    
    func appySkin() {
        switch self.navigationType {
        case .main:
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: ColorUtils.white]
            self.navigationView.imgPoster.backgroundColor = ColorUtils.white
            self.navigationControl.backgroundColor = .clear
            self.navigationControl.navigationLeftButton.tintColor = ColorUtils.babyBlue
            self.navigationControl.navigationRightButton.tintColor = ColorUtils.white
            self.navigationLargeTitleLabel.textColor = ColorUtils.white
        case .default:
            self.navigationView.imgPoster.image = nil
            self.navigationControl.backgroundColor = ColorUtils.charcoalGray
            self.navigationView.imgPoster.backgroundColor = ColorUtils.babyBlue
            self.navigationControl.navigationBarTitle.tintColor = ColorUtils.babyBlue
            self.navigationControl.navigationLeftButton.tintColor = ColorUtils.babyBlue
            self.navigationControl.navigationRightButton.tintColor = ColorUtils.babyBlue
            self.navigationLargeTitleLabel.textColor = ColorUtils.white
        }
        setBarButtonStyle()
    }
    func headerHeight(type: NavigationType) -> CGFloat {
        switch type {
        case .default, .main:
            return parallexHeight + self.topSafeArea()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBigNavigation()
        appySkin()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.isNavigationBarHidden = true
        parallaxCollectionView.parallaxHeader.view = self.navigationView
        self.view.addSubview(navigationControl)
        self.navigationView.imgPoster.addSubview(navigationLargeTitleLabel)
        self.view.addSubview(navSubTittle)
        navigationControl.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(segementHeight + self.topSafeArea())
        }
        parallaxCollectionView.parallaxHeader.height = self.headerHeight(type: self.navigationType)
        switch self.navigationType {
        case .default, .main:
            parallaxCollectionView.parallaxHeader.minimumHeight = segementHeight + self.topSafeArea()
            navigationLargeTitleLabel.snp.makeConstraints { make in
                make.left.equalTo(padding)
                make.top.equalTo(segementHeight + navigationControl.navigationBar.height)
                make.height.equalTo(segementHeight)
            }
            navSubTittle.snp.makeConstraints { make in
                make.left.equalTo(padding)
                make.right.equalTo(padding)
                make.top.equalTo(segementHeight +
                    navigationLargeTitleLabel.frame.height +
                    navigationControl.navigationBar.height)
            }
        }
        parallaxCollectionView.parallaxHeader.mode = .bottomFill
        parallaxCollectionView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            UIView.animate(withDuration: 0.50) {
                self.navigationLargeTitleLabel.alpha = (parallaxHeader.progress * screenRatio) *
                    (parallaxHeader.progress - 0.75)
                self.navigationControl.navigationBarTitle.tintColor =
                    ColorUtils.white.withAlphaComponent(1 - self.navigationLargeTitleLabel.alpha)
                self.navSubTittle.alpha = self.navigationLargeTitleLabel.alpha
            }
        }
        setupBackButton()
    }
    func setupBackButton() {
        if let rootVC = self.navigationController?.viewControllers.first, rootVC == self {
            self.navigationControl.navigationLeftButton.image = UIImage.init(named: "blue-close",
                                                                             in: Bundle(for:
                                                                                self.classForCoder),
                                                                             compatibleWith: nil)
        } else {
            self.navigationControl.navigationLeftButton.image = UIImage.init(named: "white-back",
                                                                             in: Bundle(for:
                                                                                self.classForCoder),
                                                                             compatibleWith: nil)
        }
        self.navigationControl.navigationLeftButton.target = self
        self.navigationControl.navigationLeftButton.action = #selector(self.backButtonAction)
    }
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        if let rootVC = self.navigationController?.viewControllers.first, rootVC == self {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setupBigNavigation() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: ColorUtils.babyBlue]
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedString.Key.font: FontUtils.title2,
                 NSAttributedString.Key.foregroundColor: ColorUtils.babyBlue]
        }
    }
    func systemVersionLessThan(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }
}
extension UIViewController {
    typealias MethodHandler = () -> Void
    var mainViewSafeAreaWidth: CGFloat {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            if #available(iOS 11.0, *) {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.left,
                    topPadding > 0 {
                    return self.view.frame.width - (topPadding * 2)
                }
            }
        }
        return self.view.frame.width
    }
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
extension UIScreen {
    func widthOfSafeArea() -> CGFloat {
        guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        if #available(iOS 11.0, *) {
            let leftInset = rootView.safeAreaInsets.left
            let rightInset = rootView.safeAreaInsets.right
            return rootView.bounds.width - leftInset - rightInset
        } else {
            return rootView.bounds.width
        }
    }
    func heightOfSafeArea() -> CGFloat {
        guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        if #available(iOS 11.0, *) {
            let topInset = rootView.safeAreaInsets.top
            let bottomInset = rootView.safeAreaInsets.bottom
            return rootView.bounds.height - topInset - bottomInset
        } else {
            return rootView.bounds.height
        }
    }
}
