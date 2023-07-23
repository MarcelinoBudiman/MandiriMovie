//
//  Presenter.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit

class MoviePresenter: MovieViewToPresenterProtocol {
    
    var view: MoviePresenterToViewProtocol?
    var genre: String?
    var isFetching: Bool?
    
    var interactor: MoviePresenterToInteractorProtocol?{
        didSet {
            view?.showLoading()
            Task {
                await interactor?.fetchMovies(genre: genre ?? "", page: nil)
                await MainActor.run {
                    view?.hideLoading()
                }
            }
        }
    }
    
    var router: MoviePresenterToRouterProtocol?
    
    func showMovieDetailView(with movieID: String, navigationController: UINavigationController) {
        router?.moveToMovieDetailView(with: movieID, navigationController: navigationController)
    }
    
    func generateURLRequestForPoster(with posterPath: String) -> URLRequest {
        let url = URL(string: "https://image.tmdb.org/t/p/w92\(posterPath)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        return urlRequest
        
    }
    
    func fetchMoreMovie(page: Int) {
        self.isFetching = true
        Task { [weak self] in
            await self?.interactor?.fetchMovies(genre: self?.genre ?? "", page: page)
            await MainActor.run { [weak self] in
                self?.isFetching = false
            }
        }
      
    }
    
    
}

extension MoviePresenter: MovieInteractorToPresenterProtocol {
    func fetchedMoviesWithResult(with result: Result<BodyMovie, Error>) {
        switch result {
        case .success(let body):
            view?.showMovies(with: body.results)
        case .failure(let error):
            print(error)
            view?.showMovies(with: error.localizedDescription)
        }
    }
    
}
