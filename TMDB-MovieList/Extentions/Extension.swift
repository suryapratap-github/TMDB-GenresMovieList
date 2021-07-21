//
//  Movie+Extensions.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import Foundation

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>() throws -> D? {
        guard let url = self.url(forResource: "movie_list", withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
