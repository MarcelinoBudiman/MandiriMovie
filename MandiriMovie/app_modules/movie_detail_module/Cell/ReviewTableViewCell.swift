//
//  ReviewTableViewCell.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 23/07/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER NAME"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var contentTextView: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER CONTENT"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            contentTextView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            contentTextView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        
        ])
        
    }
    
    func inflateCell(username: String, content: String) {
        
        usernameLabel.isHidden = false
        contentTextView.isHidden = false
        
        usernameLabel.text = username
        contentTextView.text = content
        
        contentView.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
