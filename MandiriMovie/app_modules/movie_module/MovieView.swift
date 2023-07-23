//
//  View.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit
import AlamofireImage

class MovieViewController: UIViewController {
    
    var presenter: MoviePresenterProtocol?
    private var movies: [Movie] = []
    private var page = 0
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var errorLabel: UILabel = {
       let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
        
    }
    
}

extension MovieViewController: MoviePresenterToViewProtocol {
    
    func showMovies(with movies: [Movie]) {
        DispatchQueue.main.async { [weak self] in
            self?.movies.append(contentsOf: movies)
            self?.tableView.isHidden = false
            self?.errorLabel.isHidden = true
            self?.tableView.tableFooterView = nil
            self?.tableView.reloadData()
            self?.page+=1
        }
    }
    
    func showMovies(with error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorLabel.text = error
            self?.tableView.isHidden = true
            self?.errorLabel.isHidden = false
            self?.tableView.reloadData()
        }
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

extension MovieViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movie = movies[indexPath.row]
        
        self.inflateCell(with: movie, cell: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let navigationController = navigationController {
            presenter?.showMovieDetailView(with: "\(movies[indexPath.row].id)", navigationController: navigationController)
        }
        
    }
    
    func inflateCell(with movie: Movie, cell: UITableViewCell) {
        let request = presenter?.generateURLRequestForPoster(with: "\(movie.posterPath ?? "")")
        
        cell.textLabel?.text = movie.originalTitle
        
        if let request = request {
            cell.imageView?.af.setImage(withURLRequest: request, placeholderImage: UIImage(named: "Placeholder"))
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > tableView.contentSize.height+100-scrollView.frame.size.height {
            // fetch again
            
            if let isFetching = presenter?.isFetching, !isFetching {
                self.tableView.tableFooterView = tableView.createSpinnerFooter(view: self.view)
                presenter?.fetchMoreMovie(page: self.page)
            }
            
        }
        
    }
    
}
