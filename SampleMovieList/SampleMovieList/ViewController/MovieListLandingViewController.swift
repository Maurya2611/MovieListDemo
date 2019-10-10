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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UtilsFunction.showOnLoader()
        viewModel.loadMoreData()
        self.title = "Movie List"
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.isRefreshInProgress = false
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    UtilsFunction.hideOffLoader()
                }
            }
        }
    }
    func showOnViewTwins() {
        loadingView.shouldTapToDismiss = true
        loadingView.variantKey = "inAndOut"
        loadingView.speedFactor = 1.0
        loadingView.lifeSpanFactor = 2.0
        loadingView.mainColor = UIColor.green
        loadingView.sizeInContainer = CGSize(width: 100, height: 100)
        loadingView.showOnKeyWindow()
    }
    private func navigateMovieDetailsWithSelectedMovieData(_ movieDetails: MovieResult) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier:
            "MovieDetailsScreenViewController") as? MovieDetailsScreenViewController else { return }
         controller.viewModel.movieDetailData = movieDetails
        navigationController?.pushViewController(controller, animated: true)
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
        return CGSize(width: (collectionView.frame.size.width) / 3.15, height: ComponentMovieListCell.cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieDataResult.count - 1 {
            // this is the last cell, load more data
            UtilsFunction.showOnLoader()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateMovieDetailsWithSelectedMovieData(viewModel.movieDataResult[indexPath.row])
    }
}
