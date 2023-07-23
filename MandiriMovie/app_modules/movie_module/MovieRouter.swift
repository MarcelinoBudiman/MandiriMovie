//
//  Router.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit

class MovieRouter: MoviePresenterToRouterProtocol {
    
    var view: MovieView?
    
    static func createModule(with genre: String?) -> MoviePresenterToRouterProtocol {
        let router = MovieRouter()
        
        let view: MoviePresenterToViewProtocol = MovieViewController()
        let interactor: MoviePresenterToInteractorProtocol = MovieInteractor()
        let presenter: MoviePresenterProtocol = MoviePresenter()
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.isFetching = false
        presenter.interactor = interactor
        presenter.router = router
        presenter.genre = genre
        
        view.presenter = presenter
        
        router.view = view as? MovieView
        
        return router
    }
    
    func moveToMovieDetailView(with movieID: String, navigationController: UINavigationController) {
        let router = MovieDetailRouter.createModule(with: movieID)
        let initialVC = router.view
        
        if let vc = initialVC {
            navigationController.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
}
