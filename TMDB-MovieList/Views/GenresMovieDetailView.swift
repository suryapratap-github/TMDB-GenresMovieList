//
//  GenresMovieDetailView.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import SwiftUI

struct GenresMovieDetailView: View {
    
    let genresName: String
    let movieId: Int
    @ObservedObject private var movieDetailState = GenresMovieDetailState()
    let imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
                self.movieDetailState.loadMovieVideos(id: self.movieId)
                self.movieDetailState.loadMovieCredits(id: self.movieId)
                self.movieDetailState.loadMovieReviews(id: self.movieId)
            }
            
            if movieDetailState.movie != nil && movieDetailState.movieVideos != nil && movieDetailState.movieCredits != nil && movieDetailState.movieReviews != nil {
                GenresMovieDetailListView(genresName: genresName, movie: self.movieDetailState.movie!, movieVideos: movieDetailState.movieVideos!, movieCredits: movieDetailState.movieCredits!, movieReviews: movieDetailState.movieReviews!)
                
            }
            
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "", displayMode: .inline)
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
            self.movieDetailState.loadMovieVideos(id: self.movieId)
            self.movieDetailState.loadMovieCredits(id: self.movieId)
            self.movieDetailState.loadMovieReviews(id: self.movieId)
        }
    }
}

struct GenresMovieDetailListView: View {
    
    let genresName: String
    let movie: Movie
    let movieVideos: MovieVideosResponse
    let movieCredits: MovieCreditsResponse
    let movieReviews: MovieReviewsResponse
    @State private var selectedTrailer: MovieVideo?
    let imageLoader = ImageLoader()
    
    var body: some View {
        List {
            GenresMovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                if genresName != "" {
                    if (self.movie.genres?.first(where: { $0.name == genresName })) != nil {
                        Text(genresName)
                    } else {
                        Text(movie.genreText)
                    }
                    
                } else {
                    Text(movie.genreText)
                }
                Text("·")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            
            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            
            Divider()
            
            HStack(alignment: .top, spacing: 4) {
                if movieCredits.cast != nil && movieCredits.cast!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring").font(.headline)
                        ForEach(self.movieCredits.cast!) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                }
                
                if movieCredits.crew != nil && movieCredits.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movieCredits.directors != nil && movieCredits.directors!.count > 0 {
                            Text("Director(s)").font(.headline)
                            ForEach(self.movieCredits.directors!) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if movieCredits.producers != nil && movieCredits.producers!.count > 0 {
                            Text("Producer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movieCredits.producers!) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if movieCredits.screenWriters != nil && movieCredits.screenWriters!.count > 0 {
                            Text("Screenwriter(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movieCredits.screenWriters!) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Divider()
            
            if movieReviews.results != nil && movieReviews.results!.count > 0 {
                Text("Reviews").font(.headline)
                
                ForEach(movieReviews.results!) { review in
                    VStack {
                        VStack {
                        GenresMovieReviewsImage(imageLoader: imageLoader, imageURL: review.authorDetails!.avatarURL)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            
                            Text(review.author)
                        }
                        Spacer()
                        Text(review.content)
                        
                    }
                }
            }
            Divider()
            
            if movieVideos.youtubeTrailers != nil && movieVideos.youtubeTrailers!.count > 0 {
                Text("Trailers").font(.headline)
                
                ForEach(movieVideos.youtubeTrailers!) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariBrowserView(url: trailer.youtubeURL!)
        }
    }
}

struct GenresMovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct GenresMovieReviewsImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .frame(width: 80, height: 80)
            }
        }
        .aspectRatio(1/1, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct GenresMovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GenresMovieDetailView(genresName: "", movieId: Movie.firstinsexOfMovie.id)
        }
    }
}
