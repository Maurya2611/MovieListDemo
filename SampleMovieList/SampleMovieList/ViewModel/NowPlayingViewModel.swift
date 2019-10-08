//
//  NowPlayingViewModel.swift
//  SampleMovieList
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import UIKit
protocol reloadDataWithCollectionView {
    func reloadDataWithSucess()
}
class NowPlayingViewModel: BaseProtocols {
    var movieDataResult: [MovieResult]?
    var networkManager: NetworkManager!
    var page: Int = 0
    var reloadTable: () -> Void = { }
    var baseDataModel: BaseDataModel?
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}
extension NowPlayingViewModel: reloadDataWithCollectionView {
    func reloadDataWithSucess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.networkManager.getNowPlayingListData(page: self.page, completion: { ( movies, error) in
                if let serverError = error, !serverError.isEmpty {
                } else {
                    DispatchQueue.main.async {
                        guard let responseData = movies else {
                            return
                        }
                        self.movieDataResult = responseData
                        self.reloadTable()
                    }
                }
            })
        }
    }
}
