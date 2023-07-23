//
//  HomeProtocols.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 22/07/23.
//

import Foundation
import UIKit

typealias EntryPoint = HomePresenterToViewProtocol & UIViewController
typealias HomePresenterProtocol = HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol

protocol HomeViewToPresenterProtocol: AnyObject{
    
    var view: HomePresenterToViewProtocol? {get set}
    var interactor: HomePresenterToInteractorProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    
    func showMovieView(with genre: String, navigationController:UINavigationController)

}

protocol HomeInteractorToPresenterProtocol: AnyObject{
    func fetchedGenresWithResult(with: Result<BodyGenre, Error>)
}

protocol HomePresenterToViewProtocol: AnyObject{
    var presenter: HomePresenterProtocol? { get set }
    
    func showGenres(with genres:[Genre])
    func showGenres(with error: String)
    func showLoading()
    func hideLoading()
}

protocol HomePresenterToRouterProtocol: AnyObject{
    var entry: EntryPoint? { get }
    static func createModule() -> HomePresenterToRouterProtocol
    func moveToMovieView(with genre: String, navigationController:UINavigationController)
}

protocol HomePresenterToInteractorProtocol: AnyObject{
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func fetchGenres() async
}
