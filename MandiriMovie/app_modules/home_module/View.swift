//
//  View.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 22/07/23.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol?
    private var genres: [Genre] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
        ])
        
    }
    
}

extension HomeViewController: HomePresenterToViewProtocol {
    
    func showGenres(with genres: [Genre]) {
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = false
            self?.genres = genres
            self?.tableView.reloadData()
        }
 
    }
    
    func showGenres(with error: String) {
        print(error)
    }
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view.showLoader(nil)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view.dismissLoader()
        }
    }
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let navigationController = navigationController {
            presenter?.showMovieView(with: "\(genres[indexPath.row].id)", navigationController: navigationController)
        }
        
    }
    
}
