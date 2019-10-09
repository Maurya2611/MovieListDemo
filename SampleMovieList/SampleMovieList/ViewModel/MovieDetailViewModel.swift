//
//  MovieDetailViewModel.swift
//  SampleMovieList
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import Foundation
protocol MovieDetailProtocol {
    var movieDetailData: MovieResult? { get }
}
class MovieDetailViewModel: MovieDetailProtocol, BaseProtocols {
    var movieDataResult: [MovieResult] = [MovieResult]()
    var movieDetailData: MovieResult?
    var networkManager: NetworkManager!
    var page: Int = 1
    var totalPages: Int = 1
    var reloadTable: () -> Void = { }
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}
extension MovieDetailViewModel: reloadDataWithCollectionView {
    func reloadDataWithSucess(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.networkManager.getSimilarMovieData(movieID:
                self.movieDetailData?.movieId ?? 0, completion: { ( movies, error) in
                        if let serverError = error, !serverError.isEmpty {
                        } else {
                            DispatchQueue.main.async {
                                guard movies != nil else {
                                    return
                                }
                                self.movieDataResult += movies?.movieResults ?? self.movieDataResult
                                self.page += 1
                                self.totalPages = movies?.totalPages ?? 1
                                completion()
                    }
                }
            })
        }
    }
    func loadMoreData() {
        if shouldLoadMoreData(totalPage: self.totalPages, totalPageLoaded: self.page) {
            self.reloadDataWithSucess(completion: { [weak self] in
                self?.reloadTable()
            })
        }
    }
    // Condition to check load more data
    func shouldLoadMoreData(totalPage: Int, totalPageLoaded: Int) -> Bool {
        return ( totalPage >= totalPageLoaded )
    }
    func getDatefromString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        var strDate = self.movieDetailData?.releaseDate
        if let date = dateFormatterGet.date(from: self.movieDetailData?.releaseDate ?? "") {
            strDate = dateFormatterPrint.string(from: date)
        }
        return strDate ?? ""
    }
    
}
