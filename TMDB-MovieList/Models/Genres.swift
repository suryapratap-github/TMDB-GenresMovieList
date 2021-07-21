//
//  Genres.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genres]
}

struct Genres: Decodable, Identifiable, Hashable {
    static func == (lhs: Genres, rhs: Genres) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let name: String
    
}

extension Genres {
    
    static var arrayOfGenres: [Genres] {
        let response: GenresResponse? = try? Bundle.main.loadAndDecodeJSON()
        return response!.genres
    }
    
    static var firstinsexOfGenres: Genres {
        arrayOfGenres[0]
    }
    
}

