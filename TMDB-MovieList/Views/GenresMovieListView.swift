//
//  GenresMovieListView.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import SwiftUI

struct GenresMovieListView: View {
    
    let title: String
    let genresId: Int
    
    @ObservedObject private var genresMoviesListState = GenresMoviesListState()
    
    var page = 1
    
    var body: some View {
        NavigationView {
            if genresMoviesListState.genresMoviesList != nil {
                
                List(genresMoviesListState.genresMoviesList!) { genresMoviesList in
                    VStack {
                        
                        NavigationLink(destination: GenresMovieDetailView(genresName: genresMoviesList.title, movieId: genresMoviesList.id)) {
                            GenresMoviesPosterCard(genresMovie: genresMoviesList)
                                .onAppear {
                                    if self.shouldLoadNextPage(currentItem: genresMoviesList) {
                                        if (genresMoviesListState.genresMoviesListResponse!.page < genresMoviesListState.genresMoviesListResponse!.totalPages!) {
                                            self.genresMoviesListState.loadGenresMoviesLists(id: self.genresId, page: self.page+1)
                                        }
                                    }
                                    
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        
                    }
                    
                    }
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    
                }
                .navigationBarTitle(title)
                
                Text("")
                    .onAppear {
                                        
                    }
                
            } else {
                LoadingView(isLoading: self.genresMoviesListState.isLoading, error: self.genresMoviesListState.error) {
                    self.genresMoviesListState.loadGenresMoviesLists(id: self.genresId, page: self.page)
                }
            }
        }
        .onAppear {
            self.genresMoviesListState.loadGenresMoviesLists(id: self.genresId, page: self.page)
        }
        
    }
    
    private func shouldLoadNextPage(currentItem item: GenresMoviesList) -> Bool {
            let currentIndex = genresMoviesListState.genresMoviesList?.firstIndex(where: { $0.id == item.id } )
        let lastIndex = genresMoviesListState.genresMoviesList?.count ?? 1 - 1
            let offset = 5 //Load next page when 5 from bottom, adjust to meet needs
            return currentIndex == lastIndex - offset
        }
}

struct GenresMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        GenresMovieListView(title: Genres.firstinsexOfGenres.name, genresId: Genres.firstinsexOfGenres.id)
    }
}
