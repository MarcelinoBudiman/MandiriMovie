//
//  MovieDetailInteractor.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import Alamofire

class MovieDetailInteractor: MovieDetailPresenterToInteractorProtocol {
    
    
    var presenter: MovieDetailInteractorToPresenterProtocol?
    
    func fetchMovieDetail(movieID: String) async {

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)")!
        
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmZlODkwYWY3MWVmNjliMThkMGQ2MDhjZDVmYmMwOSIsInN1YiI6IjY0YmI4NzYzZTlkYTY5MDBlY2U5YWM5MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PtNBMqyoUwBIsKuNwi18yKwk-6iHWvQBn3D8a5Dhk34"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = AF.request(request as URLRequestConvertible)
                        .validate(statusCode: 200..<300)
                        .serializingDecodable(MovieDetail.self)
        
        let result = await task.result
      
        presenter?.fetchedMovieDetailWithResult(with: result.mapError({$0 as Error}))
    }
    
    func fetchMovieReview(movieID: String) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/reviews")!
        
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmZlODkwYWY3MWVmNjliMThkMGQ2MDhjZDVmYmMwOSIsInN1YiI6IjY0YmI4NzYzZTlkYTY5MDBlY2U5YWM5MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PtNBMqyoUwBIsKuNwi18yKwk-6iHWvQBn3D8a5Dhk34"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = AF.request(request as URLRequestConvertible)
                        .validate(statusCode: 200..<300)
                        .serializingDecodable(BodyReview.self)
        
        let result = await task.result
     
        presenter?.fetchedReviewWithResult(with: result.mapError({$0 as Error}))
    }
    
    
}
