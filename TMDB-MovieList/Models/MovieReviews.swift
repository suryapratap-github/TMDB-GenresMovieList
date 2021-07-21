//
//  MovieReviews.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 21/07/21.
//

import Foundation

struct MovieReviewsResponse: Decodable, Identifiable, Hashable {
    static func == (lhs: MovieReviewsResponse, rhs: MovieReviewsResponse) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let results: [MovieReviews]?
    
}

struct MovieReviews: Decodable, Identifiable {
    
    let author: String
    let authorDetails: AuthorDetails?
    let content: String
    let createdAt: String?
    let id: String
    let updatedAt: String?
    let url: String
    
}

struct AuthorDetails: Decodable {
    
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Double?
    
    var avatarURL: URL {
        return URL(string: "\(avatarPath ?? "")") ?? URL(string: "https://image.tmdb.org/t/p/w500")!
    }
}
