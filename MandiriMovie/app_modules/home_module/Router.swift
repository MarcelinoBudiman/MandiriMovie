//
//  Router.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 22/07/23.
//

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    var entry: EntryPoint?
    
    static func createModule() -> HomePresenterToRouterProtocol {
        let router = HomeRouter()
        
        let view: HomePresenterToViewProtocol = HomeViewController()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let presenter: HomePresenterProtocol = HomePresenter()
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
        
    }
    
    func moveToMovieView(with genre: String, navigationController: UINavigationController) {
        let router = MovieRouter.createModule(with: genre)
        let initialVC = router.view
        
        if let vc = initialVC {
            navigationController.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
