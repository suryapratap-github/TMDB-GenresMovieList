//
//  ApiCall.swift
//  TMDB-MovieList
//
//  Created by Surya Pratap Singh on 20/07/21.
//

import Foundation

class ApiCall: ApiServices {
    
    static let shared = ApiCall()
    private init() {}
    
    private let apiKey = "e8db82ed17e9ab064d2bd8cad9b06a94"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchGenres(completion: @escaping (Result<GenresResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/genre/movie/list") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchGenresMoviesList(id: Int, page: Int, completion: @escaping (Result<GenresMoviesListResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/discover/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "with_genres": "\(id)",
            "page": "\(page)"
        ], completion: completion)
        
    }
    
    func fetchGenresMovieDetail(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func fetchGenresMovieVideos(id: Int, completion: @escaping (Result<MovieVideosResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)/videos") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func fetchGenresMovieCredits(id: Int, completion: @escaping (Result<MovieCreditsResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)/credits") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func fetchGenresMovieReviews(id: Int, completion: @escaping (Result<MovieReviewsResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)/reviews") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            DispatchQueue.main.async (execute: {
                completion(.failure(.invalidEndpoint))
            })
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "query": query
        ], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            DispatchQueue.main.async (execute: {
                completion(.failure(.invalidEndpoint))
            })
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            DispatchQueue.main.async (execute: {
                completion(.failure(.invalidEndpoint))
            })
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                DispatchQueue.main.async (execute: {
                    completion(.failure(.apiError))
                })
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                DispatchQueue.main.async (execute: {
                    completion(.failure(.invalidResponse))
                })
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async (execute: {
                    completion(.failure(.noDataFound))
                })
                return
            }
            
            do {
                print(finalURL)
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                DispatchQueue.main.async (execute: {
                    completion(.success(decodedResponse))
                })
            } catch {
                DispatchQueue.main.async (execute: {
                    completion(.failure(.serializationError))
                })
            }
        }.resume()
    }
}
