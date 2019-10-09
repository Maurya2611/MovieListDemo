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
    var movieTittle: String? = ""
    var movieSubTitle: String? = ""
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.parallaxCollectionView = collectionView
            collectionView.register(MovieDetailCell.nib,
                                    forCellWithReuseIdentifier: MovieDetailCell.reuseIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationView.imgPoster.loadImageUsingCache(withUrl: viewModel.movieDetailData?.posterPath ?? "")
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
        return 3
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            MovieDetailCell.reuseIdentifier,
            for: indexPath) as? MovieDetailCell
        if indexPath.row == 0 {
            movieTittle = "Movie Release Date"
            movieSubTitle = viewModel.getDatefromString()
            cell?.configureCellWithData(tittle: movieTittle, subTittle: movieSubTitle)
        } else if indexPath.row == 1 {
            movieTittle = "Movie Rating"
            movieSubTitle = String(format: "%.1f / 10", viewModel.movieDetailData?.voteAverage ?? "")
            cell?.configureCellWithData(tittle: movieTittle, subTittle: movieSubTitle)
        } else if indexPath.row == 2 {
            movieTittle = "Movie Description"
            movieSubTitle = viewModel.movieDetailData?.overview
            cell?.configureCellWithData(tittle: movieTittle, subTittle: movieSubTitle)
        }
        return cell ?? UICollectionViewCell()
    }
}
extension MovieDetailsScreenViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 2 {
            let descriptionHeight = self.heightOfLableAccordingContent(collectionView.frame.size.width,
                                                    FontUtils.footNote,
                                                    viewModel.movieDetailData?.overview ?? "",
                                                    numberOfLines: 0)
            return CGSize(width: collectionView.frame.size.width,
                          height: descriptionHeight + MovieDetailCell.cellHeight)
        }
        return CGSize(width: collectionView.frame.size.width, height: MovieDetailCell.cellHeight)
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

    func heightOfLableAccordingContent(_ width: CGFloat,
                                       _ font: UIFont,
                                       _ text: String,
                                       numberOfLines: Int ) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
