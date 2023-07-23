//
//  Entity.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 22/07/23.
//

import Foundation

struct BodyGenre: Codable {
    var genres: [Genre]
}

struct Genre: Codable {
    var id: Int
    var name: String
}
