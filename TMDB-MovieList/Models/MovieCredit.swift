//
//  MovieCredit.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 21/07/21.
//

import Foundation

struct MovieCreditsResponse: Decodable, Identifiable, Hashable {
    static func == (lhs: MovieCreditsResponse, rhs: MovieCreditsResponse) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let cast: [MovieCast]?
    let crew: [MovieCrew]?
    
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}
