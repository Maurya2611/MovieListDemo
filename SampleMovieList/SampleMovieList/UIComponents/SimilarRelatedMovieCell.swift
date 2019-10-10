//
//  SimilarRelatedMovieCell.swift
//  SampleMovieList
//
//  Created by Chandresh on 10/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
class SimilarRelatedMovieCell: BaseReusableTableView {
    static let cellHeight: CGFloat = 320
    var viewModel: MovieDetailViewModel?
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(CarouselContentViewCell.nib,
                                    forCellWithReuseIdentifier: CarouselContentViewCell.reuseIdentifier)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCellWithData(viewModel: MovieDetailViewModel?) {
        self.viewModel = viewModel
        self.collectionView.reloadData()
    }
}
extension SimilarRelatedMovieCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieDataResult.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselContentViewCell.reuseIdentifier,
                                                      for: indexPath) as? CarouselContentViewCell
        if viewModel?.movieDataResult.count ?? 1 > 0 {
            let movieResult = viewModel?.movieDataResult[indexPath.row]
            cell?.loadCellWithData(imageURL: movieResult?.posterPath)
        }
        return cell ?? UICollectionViewCell(frame: CGRect.zero)
    }
}
extension SimilarRelatedMovieCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width / 2.30, height: CarouselContentViewCell.cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension SimilarRelatedMovieCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected at \(indexPath.row)")
    }
}
