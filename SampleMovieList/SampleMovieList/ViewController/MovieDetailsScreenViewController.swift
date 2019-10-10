//
//  MovieDetailsScreenViewController.swift
//  SampleMovieList
//
//  Created by Chandresh on 10/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import UIKit
class MovieDetailsScreenViewController: MainBaseViewController {
    var viewModel: MovieDetailViewModel = MovieDetailViewModel(networkManager: NetworkManager())
    @IBOutlet weak var tblview: UITableView! {
        didSet {
            tblview.register(MovieDetailListCell.nib, forCellReuseIdentifier: MovieDetailListCell.reuseIdentifier)
            tblview.register(SimilarRelatedMovieCell.nib,
                             forCellReuseIdentifier: SimilarRelatedMovieCell.reuseIdentifier)
            self.parallaxTableView = tblview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.loadImageUsingCache(withUrl: viewModel.movieDetailData?.posterPath ?? "")
        if NetworkReachability.isInterNetExist() {
            UtilsFunction.showOnLoader()
            viewModel.loadMoreData()
        } else {
            let alert = UIAlertController(title: "No Internet connection",
                                          message: "Turn on mobile data or use Wi-Fi to access data.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        self.viewModel.reloadTable = { [weak self] in
            self?.tblview.reloadData()
            DispatchQueue.main.async {
                UtilsFunction.hideOffLoader()
            }
        }
        self.viewModel.navigateSimilarMovieWithData = { movieResult in
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier:
                "MovieDetailsScreenViewController") as? MovieDetailsScreenViewController else { return }
            controller.viewModel.movieDetailData = movieResult
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
// MARK: - UITableViewDataSource Called Here
extension MovieDetailsScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movieDataResult.count > 0 ? 2 : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailListCell.reuseIdentifier,
                                                           for: indexPath)
                as? MovieDetailListCell else { return UITableViewCell()
            }
            viewModel.getMovieDetailDatalist(indexPath, cell)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarRelatedMovieCell.reuseIdentifier,
                                                       for: indexPath)
            as? SimilarRelatedMovieCell else { return UITableViewCell()
        }
        cell.configureCellWithData(viewModel: viewModel)
        return cell
    }
}
extension MovieDetailsScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 3 {
                let descriptionHeight = UtilsFunction.heightOfLableAccordingContent(
                    self.view.frame.size.width,
                    FontUtils.footNote,
                    viewModel.movieDetailData?.overview ?? "",
                    numberOfLines: 0)
                return MovieDetailListCell.cellHeight + descriptionHeight
            }
            return MovieDetailListCell.cellHeight
        }
        return SimilarRelatedMovieCell.cellHeight
    }
}
