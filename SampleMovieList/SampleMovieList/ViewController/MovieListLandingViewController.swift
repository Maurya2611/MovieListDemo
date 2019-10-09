//
//  MovieListLandingViewController.swift
//  SampleMovieList
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import UIKit
import RSLoadingView
class MovieListLandingViewController: UIViewController {
    var viewModel: NowPlayingViewModel = NowPlayingViewModel(networkManager: NetworkManager())
    var isRefreshInProgress = false
    let loadingView = RSLoadingView(effectType: RSLoadingView.Effect.spinAlone)

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ComponentMovieListCell.nib,
                                    forCellWithReuseIdentifier: ComponentMovieListCell.reuseIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showOnViewTwins()
        viewModel.loadMoreData()
        self.title = "Movie List"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.50) {
                    self?.loadingView.hide()
                    self?.loadingView.removeFromSuperview()
                    self?.collectionView.reloadData()
                    self?.isRefreshInProgress = false
                }
            }
        }
    }
    func showOnViewTwins() {
        loadingView.shouldTapToDismiss = true
        loadingView.variantKey = "inAndOut"
        loadingView.speedFactor = 2.0
        loadingView.lifeSpanFactor = 2.0
        loadingView.mainColor = UIColor.green
        loadingView.sizeInContainer = CGSize(width: 100, height: 100)
        loadingView.showOnKeyWindow()
    }
}
// MARK: - UICollectioViewDataSource methods
extension MovieListLandingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieDataResult.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComponentMovieListCell.reuseIdentifier,
            for: indexPath) as? ComponentMovieListCell
        let movieResult = viewModel.movieDataResult[indexPath.row]
        cell?.configureCellWithData(moviePostUrl: movieResult.posterPath)
        return cell ?? UICollectionViewCell()
    }
}
extension MovieListLandingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width) / 3.05, height: ComponentMovieListCell.cellHeight)
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
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieDataResult.count - 1 {
            // this is the last cell, load more data
            showOnViewTwins()
            viewModel.loadMoreData()
        }
    }
    @objc(collectionView:
    layout:
    minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView,
                                                              layout collectionViewLayout: UICollectionViewLayout,
                                                              minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
