//
//  MovieVideo.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 21/07/21.
//

import Foundation

struct MovieVideosResponse: Decodable, Identifiable, Hashable {
    static func == (lhs: MovieVideosResponse, rhs: MovieVideosResponse) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let results: [MovieVideo]
    
    var youtubeTrailers: [MovieVideo]? {
        results.filter { $0.youtubeURL != nil }
    }
}

struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
