//
//  BaseDataModel.swift
//  DataModel
//
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
/*
   let baseDataModel = try BaseDataModel(json)
   let track = try Track(json) */

import Foundation
struct BaseDataModel: Codable {
    let movieResults: [MovieResult]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    enum CodingKeys: String, CodingKey {
        case movieResults = "results"
        case page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}
// MARK: BaseDataModel convenience initializers & mutators
extension BaseDataModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BaseDataModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        movieResults: [MovieResult]?? = nil,
        page: Int?? = nil,
        totalResults: Int?? = nil,
        dates: Dates?? = nil,
        totalPages: Int?? = nil
        ) -> BaseDataModel {
        return BaseDataModel(
            movieResults: movieResults ?? self.movieResults,
            page: page ?? self.page,
            totalResults: totalResults ?? self.totalResults,
            dates: dates ?? self.dates,
            totalPages: totalPages ?? self.totalPages
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: Dates convenience initializers and mutators
extension Dates {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dates.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        maximum: String?? = nil,
        minimum: String?? = nil
        ) -> Dates {
        return Dates(
            maximum: maximum ?? self.maximum,
            minimum: minimum ?? self.minimum
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MovieResult
struct MovieResult: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let movieId: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case movieId = "id", adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

// MARK: MovieResult convenience initializers and mutators

extension MovieResult {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MovieResult.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        popularity: Double?? = nil,
        voteCount: Int?? = nil,
        video: Bool?? = nil,
        posterPath: String?? = nil,
        movieId: Int?? = nil,
        adult: Bool?? = nil,
        backdropPath: String?? = nil,
        originalLanguage: OriginalLanguage?? = nil,
        originalTitle: String?? = nil,
        genreIDS: [Int]?? = nil,
        title: String?? = nil,
        voteAverage: Double?? = nil,
        overview: String?? = nil,
        releaseDate: String?? = nil
        ) -> MovieResult {
        return MovieResult(
            popularity: popularity ?? self.popularity,
            voteCount: voteCount ?? self.voteCount,
            video: video ?? self.video,
            posterPath: posterPath ?? self.posterPath,
            movieId: movieId ?? self.movieId,
            adult: adult ?? self.adult,
            backdropPath: backdropPath ?? self.backdropPath,
            originalLanguage: originalLanguage ?? self.originalLanguage,
            originalTitle: originalTitle ?? self.originalTitle,
            genreIDS: genreIDS ?? self.genreIDS,
            title: title ?? self.title,
            voteAverage: voteAverage ?? self.voteAverage,
            overview: overview ?? self.overview,
            releaseDate: releaseDate ?? self.releaseDate
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case ru = "ru"
    case tl = "tl"
}

// MARK: - Track
struct Track: Codable {
    let name: String?
    let duration: Int?
}

// MARK: Track convenience initializers and mutators

extension Track {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Track.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        name: String?? = nil,
        duration: Int?? = nil
        ) -> Track {
        return Track(
            name: name ?? self.name,
            duration: duration ?? self.duration
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
