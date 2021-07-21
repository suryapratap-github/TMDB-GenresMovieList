//
//  GenresMoviesPosterCard.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import SwiftUI

struct GenresMoviesPosterCard: View {
    
    let genresMovie: GenresMoviesList
    
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .clipped()
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(genresMovie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(minHeight: 306, maxHeight: .infinity)
        .onAppear {
            self.imageLoader.loadImage(with: self.genresMovie.posterURL)
        }
    }
}

struct GenresMoviesPosterCard_Previews: PreviewProvider {
    static var previews: some View {
        GenresMoviesPosterCard(genresMovie: GenresMoviesList.firstinsexOfGenresMoviesList)
    }
}

