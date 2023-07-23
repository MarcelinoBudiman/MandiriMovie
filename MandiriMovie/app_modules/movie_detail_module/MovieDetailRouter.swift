//
//  MovieDetailRouter.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit

class MovieDetailRouter: MovieDetailPresenterToRouterProtocol {
    var view: MovieDetailView?
    
    static func createModule(with movieID: String?) -> MovieDetailPresenterToRouterProtocol {
        
        let router = MovieDetailRouter()
        
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.movieID = movieID
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        router.view = view
        
        return router
    }
    
    
}
