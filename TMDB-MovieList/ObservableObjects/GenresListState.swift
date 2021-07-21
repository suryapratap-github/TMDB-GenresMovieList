//
//  GenresListState.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import Foundation

class GenresListState: ObservableObject {
    
    @Published var genres: [Genres]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let apiServices: ApiServices
    
    init(apiServices: ApiServices = ApiCall.shared) {
        self.apiServices = apiServices
    }
    
    func loadGenres() {
        self.genres = nil
        self.isLoading = true
        self.apiServices.fetchGenres() { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.genres = response.genres
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}
