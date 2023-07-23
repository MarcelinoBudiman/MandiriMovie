//
//  Interactor.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 22/07/23.
//

import Foundation
import Alamofire

class HomeInteractor: HomePresenterToInteractorProtocol {
    
    var presenter: HomeInteractorToPresenterProtocol?
    
    func fetchGenres() async {
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list")!
        
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmZlODkwYWY3MWVmNjliMThkMGQ2MDhjZDVmYmMwOSIsInN1YiI6IjY0YmI4NzYzZTlkYTY5MDBlY2U5YWM5MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PtNBMqyoUwBIsKuNwi18yKwk-6iHWvQBn3D8a5Dhk34"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = AF.request(request as URLRequestConvertible)
                        .validate(statusCode: 200..<300)
                        .serializingDecodable(BodyGenre.self)
        
        let result = await task.result

        presenter?.fetchedGenresWithResult(with: result.mapError({($0 as Error)}))
    }
    
    
}
