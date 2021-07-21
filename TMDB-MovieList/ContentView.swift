//
//  ContentView.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 19/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var genresState = GenresListState()
    
    var body: some View {
        NavigationView {
            List {
                
                Group {
                    if genresState.genres != nil {
                        ForEach(genresState.genres!) { genre in
                            NavigationLink(destination: GenresMovieListView(title: genre.name, genresId: genre.id)) {
                                VStack(alignment: .leading) {
                                    Text(genre.name)
                                }
                            }
                        }
                        
                    } else {
                        LoadingView(isLoading: self.genresState.isLoading, error: self.genresState.error) {
                            self.genresState.loadGenres()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                
            }
            .navigationBarTitle("TMDB-Genres List")
            .toolbar(content: {
                NavigationLink(destination: MovieSearchView()) {
                    Button(action: { print("Searching...") }, label: {
                        Label("Search", systemImage: "magnifyingglass")
                    })
                }
                
            })
        }
        .onAppear {
            self.genresState.loadGenres()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
