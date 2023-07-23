//
//  MovieProtocols.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit

typealias MovieView = MoviePresenterToViewProtocol & UIViewController
typealias MoviePresenterProtocol = MovieViewToPresenterProtocol & MovieInteractorToPresenterProtocol

protocol MovieViewToPresenterProtocol: AnyObject{
    
    var view: MoviePresenterToViewProtocol? {get set}
    var interactor: MoviePresenterToInteractorProtocol? {get set}
    var router: MoviePresenterToRouterProtocol? {get set}
    var genre: String? {get set}
    var isFetching: Bool? {get set}
    
    func showMovieDetailView(with movieID: String, navigationController:UINavigationController)
    func generateURLRequestForPoster(with url: String) -> URLRequest
    func fetchMoreMovie(page: Int)
}

protocol MovieInteractorToPresenterProtocol: AnyObject{
    func fetchedMoviesWithResult(with: Result<BodyMovie, Error>)
}

protocol MoviePresenterToViewProtocol: AnyObject{
    var presenter: MoviePresenterProtocol? {get set}
    
    func showMovies(with movies:[Movie])
    func showMovies(with error: String)
    func showLoading()
    func hideLoading()
}

protocol MoviePresenterToRouterProtocol: AnyObject{
    var view: MovieView? { get }
    static func createModule(with genre: String?) -> MoviePresenterToRouterProtocol
    func moveToMovieDetailView(with movieID: String, navigationController:UINavigationController)
}

protocol MoviePresenterToInteractorProtocol: AnyObject{
    var presenter:MovieInteractorToPresenterProtocol? {get set}
    func fetchMovies(genre: String, page: Int?) async
}
