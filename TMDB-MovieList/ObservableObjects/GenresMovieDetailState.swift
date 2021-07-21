//
//  GenresMovieDetailState.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import SwiftUI

class GenresMovieDetailState: ObservableObject {
    
    private let apiService: ApiServices
    @Published var movie: Movie?
    @Published var movieVideos: MovieVideosResponse?
    @Published var movieCredits: MovieCreditsResponse?
    @Published var movieReviews: MovieReviewsResponse?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(apiService: ApiServices = ApiCall.shared) {
        self.apiService = apiService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.apiService.fetchGenresMovieDetail(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    
    func loadMovieVideos(id: Int) {
        self.movieVideos = nil
        self.isLoading = false
        self.apiService.fetchGenresMovieVideos(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movieVideos):
                self.movieVideos = movieVideos
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    
    func loadMovieCredits(id: Int) {
        self.movieCredits = nil
        self.isLoading = false
        self.apiService.fetchGenresMovieCredits(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movieCredits):
                self.movieCredits = movieCredits
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func loadMovieReviews(id: Int) {
        self.movieReviews = nil
        self.isLoading = false
        self.apiService.fetchGenresMovieReviews(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movieReviews):
                self.movieReviews = movieReviews
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
