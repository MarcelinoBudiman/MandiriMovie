//
//  Interactor.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import Alamofire

class MovieInteractor: MoviePresenterToInteractorProtocol {
    var presenter: MovieInteractorToPresenterProtocol?
    
    func fetchMovies(genre: String, page: Int?) async {
        
        let url: URL?
        
        if let page = page, page > 0 {
            url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
                .appending("page", value: "\(page)")
                .appending("with_genres", value: genre)
                
        } else {
            url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
                .appending("with_genres", value: genre)
        }
        
        
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmZlODkwYWY3MWVmNjliMThkMGQ2MDhjZDVmYmMwOSIsInN1YiI6IjY0YmI4NzYzZTlkYTY5MDBlY2U5YWM5MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PtNBMqyoUwBIsKuNwi18yKwk-6iHWvQBn3D8a5Dhk34"
        ]
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = AF.request(request as URLRequestConvertible)
                        .validate(statusCode: 200..<300)
                        .serializingDecodable(BodyMovie.self)
        
        let result = await task.result
 
        presenter?.fetchedMoviesWithResult(with: result.mapError({$0 as Error}))
    }
    
    
}
