//
//  MovieDetailView.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenterProtocol?
    
    private var movieDetail: MovieDetail?
    private var reviews: [Review] = []
    private var page: Int = 0
    private var maxPage = 0
    
    var posterImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "Placeholder")!)
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER NAME"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieTaglineLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER TAGLINE"
        label.numberOfLines = 2
        label.isHidden = true
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieGenresLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER GENRE"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER DURATION"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER RATING"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieGenreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieDurationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Duration"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieRatingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.isHidden = true
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        
        let topView = UIView()
        let bottomView = UIView()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        bottomView.addSubview(posterImageView)
        bottomView.addSubview(tableView)
        bottomView.addSubview(movieNameLabel)
        bottomView.addSubview(movieTaglineLabel)
        bottomView.addSubview(movieGenresLabel)
        bottomView.addSubview(movieDurationLabel)
        bottomView.addSubview(movieRatingLabel)
        bottomView.addSubview(movieGenreTitleLabel)
        bottomView.addSubview(movieDurationTitleLabel)
        bottomView.addSubview(movieRatingTitleLabel)
        bottomView.addSubview(errorLabel)
        bottomView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            topView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            topView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            bottomView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            bottomView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            
            
            posterImageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            posterImageView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.25),
            posterImageView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.3),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            movieNameLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 10),
            
            movieTaglineLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            movieTaglineLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 3),

            movieGenreTitleLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            movieGenreTitleLabel.topAnchor.constraint(equalTo: movieTaglineLabel.bottomAnchor, constant: 20),
            movieGenreTitleLabel.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.05),
            
            movieDurationTitleLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            movieDurationTitleLabel.topAnchor.constraint(equalTo: movieGenresLabel.bottomAnchor, constant: 10),
            
            movieRatingTitleLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            movieRatingTitleLabel.topAnchor.constraint(equalTo: movieDurationTitleLabel.bottomAnchor, constant: 10),
            
            movieGenresLabel.leadingAnchor.constraint(equalTo: movieDurationTitleLabel.trailingAnchor, constant: 10),
            movieGenresLabel.topAnchor.constraint(equalTo: movieGenreTitleLabel.topAnchor),
            movieGenresLabel.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.05),
            
            movieDurationLabel.leadingAnchor.constraint(equalTo: movieDurationTitleLabel.trailingAnchor, constant: 10),
            movieDurationLabel.topAnchor.constraint(equalTo: movieDurationTitleLabel.topAnchor),
            
            movieRatingLabel.leadingAnchor.constraint(equalTo: movieDurationTitleLabel.trailingAnchor, constant: 10),
            movieRatingLabel.topAnchor.constraint(equalTo: movieRatingTitleLabel.topAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            tableView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.65)
        
        ])
        
        
    }
    
}

extension MovieDetailViewController: MovieDetailPresenterToViewProtocol {
 
    func showMovieDetail(with movieDetail: MovieDetail) {
        DispatchQueue.main.async { [weak self] in
            
            self?.movieDetail = movieDetail
            self?.updateLabels()
            
            self?.view.layoutIfNeeded()
        }
    }
    
    func updateLabels() {
        if let movieDetail = self.movieDetail {
            
            self.posterImageView.isHidden = false
            self.tableView.isHidden = false
            self.movieNameLabel.isHidden = false
            self.movieTaglineLabel.isHidden = false
            self.movieGenresLabel.isHidden = false
            self.movieRatingLabel.isHidden = false
            self.movieDurationLabel.isHidden = false
            self.movieGenreTitleLabel.isHidden = false
            self.movieRatingTitleLabel.isHidden = false
            self.movieDurationTitleLabel.isHidden = false
            
            self.movieNameLabel.text = movieDetail.originalTitle
            self.movieTaglineLabel.text = movieDetail.tagline
            self.movieRatingLabel.text = String(movieDetail.voteAverage*100/100)
            self.movieDurationLabel.text = "\(movieDetail.runtime) mins"
            
            var genreText = ""
            
            for genre in movieDetail.genres {
                genreText += ", \(genre.name)"
            }
            genreText = String(genreText.dropFirst(2))
            self.movieGenresLabel.text = genreText
            
            let request = presenter?.generateURLRequestForPoster(with: movieDetail.posterPath ?? "")
            if let request = request {
                self.posterImageView.af.setImage(withURLRequest: request, placeholderImage: UIImage(named: "Placeholder")!)
            }
            
        }
    }
    
    func showMovieDetail(with error: String) {
        DispatchQueue.main.async {[weak self] in
            self?.posterImageView.isHidden = true
            self?.tableView.isHidden = true
            self?.movieNameLabel.isHidden = true
            self?.movieTaglineLabel.isHidden = true
            self?.movieGenresLabel.isHidden = true
            self?.movieRatingLabel.isHidden = true
            self?.movieDurationLabel.isHidden = true
            self?.movieGenreTitleLabel.isHidden = true
            self?.movieRatingTitleLabel.isHidden = true
            self?.movieDurationTitleLabel.isHidden = true
            
            self?.errorLabel.text = error
            self?.errorLabel.isHidden = false
            
            self?.view.layoutIfNeeded()
        }
        
    }
    
    func showReview(with reviews: [Review], maxPages: Int) {

        DispatchQueue.main.async { [weak self] in
            
            self?.posterImageView.isHidden = false
            self?.tableView.isHidden = false
            self?.movieNameLabel.isHidden = false
            self?.movieTaglineLabel.isHidden = false
            self?.movieGenresLabel.isHidden = false
            self?.movieRatingLabel.isHidden = false
            self?.movieDurationLabel.isHidden = false
            self?.movieGenreTitleLabel.isHidden = false
            self?.movieRatingTitleLabel.isHidden = false
            self?.movieDurationTitleLabel.isHidden = false
            
            self?.reviews.append(contentsOf: reviews)
            self?.maxPage = maxPages
            
            self?.errorLabel.isHidden = true
            self?.tableView.tableFooterView = nil
            self?.tableView.reloadData()
            self?.page+=1
        }
    }
    
    func showReview(with error: String) {
        DispatchQueue.main.async {[weak self] in
            self?.posterImageView.isHidden = true
            self?.tableView.isHidden = true
            self?.movieNameLabel.isHidden = true
            self?.movieTaglineLabel.isHidden = true
            self?.movieGenresLabel.isHidden = true
            self?.movieRatingLabel.isHidden = true
            self?.movieDurationLabel.isHidden = true
            self?.movieGenreTitleLabel.isHidden = true
            self?.movieRatingTitleLabel.isHidden = true
            self?.movieDurationTitleLabel.isHidden = true
            
            self?.errorLabel.text = error
            self?.errorLabel.isHidden = false
            
            self?.view.layoutIfNeeded()
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

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ReviewTableViewCell
        let review = reviews[indexPath.row]
     
        cell.inflateCell(username: review.authorDetails.username, content: review.content)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > tableView.contentSize.height+100-scrollView.frame.size.height {
            // fetch again
            
            if let isFetching = presenter?.isFetching, !isFetching, page < self.maxPage {
                self.tableView.tableFooterView = tableView.createSpinnerFooter(view: self.view)
                presenter?.fetchMoreReview(page: self.page)
            }
            
        }
        
    }
    
}
