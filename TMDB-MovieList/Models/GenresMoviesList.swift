//
//  GenresMovies.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import Foundation

struct GenresMoviesListResponse: Decodable {
    let page: Int
    let results: [GenresMoviesList]
    let totalPages: Int?
    let totalResults: Int?
    
}

struct GenresMoviesList: Decodable, Identifiable, Hashable {
    static func == (lhs: GenresMoviesList, rhs: GenresMoviesList) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let mediaType: String?
    let title: String
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int?
   
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return GenresMoviesList.yearFormatter.string(from: date)
    }
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
}

extension GenresMoviesList {
    
    static var arrayOfGenresMoviesList: [GenresMoviesList] {
        let response: GenresMoviesListResponse? = try? Bundle.main.loadAndDecodeJSON()
        return response!.results
    }
    
    static var firstinsexOfGenresMoviesList: GenresMoviesList {
        arrayOfGenresMoviesList[0]
    }
    
}
