//
//  MovieDetailProtocol.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit

typealias MovieDetailView = MovieDetailPresenterToViewProtocol & UIViewController
typealias MovieDetailPresenterProtocol = MovieDetailViewToPresenterProtocol & MovieDetailInteractorToPresenterProtocol

protocol MovieDetailViewToPresenterProtocol: AnyObject{
    
    var view: MovieDetailPresenterToViewProtocol? {get set}
    var interactor: MovieDetailPresenterToInteractorProtocol? {get set}
    var router: MovieDetailPresenterToRouterProtocol? {get set}
    var movieID: String? {get set}
    var isFetching: Bool? {get set}
    
    func generateURLRequestForPoster(with posterPath: String) -> URLRequest
    func fetchMoreReview(page: Int)
    
}

protocol MovieDetailPresenterToInteractorProtocol: AnyObject{
    var presenter:MovieDetailInteractorToPresenterProtocol? {get set}
    func fetchMovieDetail(movieID: String) async
    func fetchMovieReview(movieID: String) async
}

protocol MovieDetailInteractorToPresenterProtocol: AnyObject{
    func fetchedMovieDetailWithResult(with result: Result<MovieDetail, Error>)
    func fetchedReviewWithResult(with result: Result<BodyReview, Error>)
}

protocol MovieDetailPresenterToViewProtocol: AnyObject{
    var presenter: MovieDetailPresenterProtocol? {get set}
    
    func showMovieDetail(with movieDetail:MovieDetail)
    func showMovieDetail(with error: String)
    func showReview(with reviews:[Review], maxPages:Int)
    func showReview(with error: String)
    func showLoading()
    func hideLoading()
}

protocol MovieDetailPresenterToRouterProtocol: AnyObject{
    var view: MovieDetailView? { get }
    static func createModule(with movieID: String?) -> MovieDetailPresenterToRouterProtocol
}

