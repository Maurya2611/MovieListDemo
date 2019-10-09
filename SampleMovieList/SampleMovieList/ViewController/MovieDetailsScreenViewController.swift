//
//  MovieDetailsScreenViewController.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit

class MovieDetailsScreenViewController: MainBaseViewController {
    var viewModel: MovieDetailViewModel = MovieDetailViewModel(networkManager: NetworkManager())
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.parallaxCollectionView = collectionView
            collectionView.register(ComponentMovieListCell.nib,
                                    forCellWithReuseIdentifier: ComponentMovieListCell.reuseIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationView.imgPoster.loadImageUsingCache(withUrl: viewModel.movieDetailData?.backdropPath ?? "")
        self.title = viewModel.movieDetailData?.originalTitle?.uppercased()
        // Do any additional setup after loading the view.
    }
    override var navigationType: NavigationType {
        return .main
    }
}
// MARK: - UICollectioViewDataSource methods
extension MovieDetailsScreenViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            ComponentMovieListCell.reuseIdentifier,
            for: indexPath) as? ComponentMovieListCell
        return cell ?? UICollectionViewCell()
    }
}
extension MovieDetailsScreenViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: ComponentMovieListCell.cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
    }
    @objc(collectionView:
    layout:
    minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView,
                                                              layout collectionViewLayout: UICollectionViewLayout,
                                                              minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

}
