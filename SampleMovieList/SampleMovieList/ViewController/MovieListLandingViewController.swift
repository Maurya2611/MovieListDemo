//
//  MovieListLandingViewController.swift
//  SampleMovieList
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import UIKit
class MovieListLandingViewController: UIViewController {
    var viewModel: NowPlayingViewModel = NowPlayingViewModel(networkManager: NetworkManager())
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ComponentMovieListCell.nib,
                                    forCellWithReuseIdentifier: ComponentMovieListCell.reuseIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadDataWithSucess()
        self.title = "Movie List"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.50) {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = collectionView.contentOffset.y >= 0
            && collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.frame.size.height)
        if isReachingEnd {
             viewModel.page += 1
             viewModel.reloadDataWithSucess()
        }
    }
}
// MARK: - UICollectioViewDataSource methods
extension MovieListLandingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieDataResult?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComponentMovieListCell.reuseIdentifier,
                                                      for: indexPath) as? ComponentMovieListCell
        if let movieResult = viewModel.movieDataResult?[indexPath.row] {
            cell?.configureCellWithData(moviePostUrl: movieResult.posterPath)
        }
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
    @objc(collectionView:
    layout:
    minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView,
                                                              layout collectionViewLayout: UICollectionViewLayout,
                                                              minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
