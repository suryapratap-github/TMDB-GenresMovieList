//
//  GenresMoviesListState.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import Foundation

class GenresMoviesListState: ObservableObject {
    
    @Published var genresMoviesListResponse: GenresMoviesListResponse?
    @Published var genresMoviesList: [GenresMoviesList]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let apiService: ApiServices
    
    init(apiService: ApiServices = ApiCall.shared) {
        self.apiService = apiService
    }
    
    func loadGenresMoviesLists(id: Int, page: Int) {
        self.genresMoviesListResponse = nil
        self.genresMoviesList = nil
        self.isLoading = true
        self.apiService.fetchGenresMoviesList(id: id, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                if page > 1 {
                    var list = [GenresMoviesList]()
                    for results in response.results {
                        list.append(results)
                    }
                    if list.count > 0 {
                        self.genresMoviesList = list
                    } else {
                        self.genresMoviesList = response.results
                    }
                    
                } else {
                    self.genresMoviesList = response.results
                }
                self.genresMoviesListResponse = response
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}
