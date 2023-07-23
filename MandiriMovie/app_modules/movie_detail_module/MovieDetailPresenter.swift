//
//  MovieDetailPresenter.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit

class MovieDetailPresenter: MovieDetailViewToPresenterProtocol {
    
    var view: MovieDetailPresenterToViewProtocol?
    
    var interactor: MovieDetailPresenterToInteractorProtocol? {
        didSet {
            self.isFetching = true
            Task { [weak self] in
                await self?.interactor?.fetchMovieDetail(movieID: self?.movieID ?? "")
                await self?.interactor?.fetchMovieReview(movieID: self?.movieID ?? "")
                
                await MainActor.run { [weak self] in
                    self?.isFetching = false
                }
                
            }
        }
    }
    
    var router: MovieDetailPresenterToRouterProtocol?
    
    var movieID: String?
    
    var isFetching: Bool?
    
    func generateURLRequestForPoster(with posterPath: String) -> URLRequest {
        let url = URL(string: "https://image.tmdb.org/t/p/w154\(posterPath)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    func fetchMoreReview(page: Int) {
        self.isFetching = true
        Task { [weak self] in
            await self?.interactor?.fetchMovieReview(movieID: self?.movieID ?? "")
            await MainActor.run { [weak self] in
                self?.isFetching = false
            }
        }
    }
    
    
}

extension MovieDetailPresenter: MovieDetailInteractorToPresenterProtocol {
    
    func fetchedReviewWithResult(with result: Result<BodyReview, Error>) {
        switch result {
        case .success(let reviews):
            view?.showReview(with: reviews.results, maxPages: reviews.totalPages)
        case .failure(let error):
            view?.showReview(with: error.localizedDescription)
        }
    }
    
    func fetchedMovieDetailWithResult(with result: Result<MovieDetail, Error>) {
        switch result {
        case .success(let detail):
            view?.showMovieDetail(with: detail)
        case .failure(let error):
            view?.showMovieDetail(with: error.localizedDescription)
        }
    }
    
}
