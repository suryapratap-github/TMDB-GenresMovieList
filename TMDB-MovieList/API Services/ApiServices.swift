//
//  ApiServices.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import Foundation

protocol ApiServices {
    func fetchGenres(completion: @escaping (Result<GenresResponse, MovieError>) -> ())
    func fetchGenresMoviesList(id: Int, page: Int, completion: @escaping (Result<GenresMoviesListResponse, MovieError>) -> ())
    func fetchGenresMovieDetail(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func fetchGenresMovieVideos(id: Int, completion: @escaping (Result<MovieVideosResponse, MovieError>) -> ())
    func fetchGenresMovieCredits(id: Int, completion: @escaping (Result<MovieCreditsResponse, MovieError>) -> ())
    func fetchGenresMovieReviews(id: Int, completion: @escaping (Result<MovieReviewsResponse, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noDataFound
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noDataFound: return "No data found"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}

