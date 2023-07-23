//
//  Presenter.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 22/07/23.
//

import Foundation
import UIKit

class HomePresenter: HomeViewToPresenterProtocol {

    var view: HomePresenterToViewProtocol?
    
    var interactor: HomePresenterToInteractorProtocol? {
        didSet {
            view?.showLoading()
            Task {
                await interactor?.fetchGenres()
                
                await MainActor.run(body: {
                    view?.hideLoading()
                })
            }
        }
    }
    
    var router: HomePresenterToRouterProtocol?

    func showMovieView(with genre: String, navigationController: UINavigationController) {
        router?.moveToMovieView(with: genre, navigationController: navigationController)
    }
    
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func fetchedGenresWithResult(with result: Result<BodyGenre, Error>) {
        switch result {
        case .success(let body):
            view?.showGenres(with: body.genres)
        case .failure(let error):
            view?.showGenres(with: error.localizedDescription)
        }
    }
    
}
