//
//  Movie.swift
//  Flix
//
//  Created by Anthony Lee on 10/29/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var overview: String
    var releaseDate: String
    var backdropURL: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
        // Set the rest of the properties
        if let posterPath = dictionary[Keys.posterPath] as? String{
            let baseUrl = Keys.baseURL
            posterUrl = URL(string: baseUrl + posterPath)!
        }
        
        overview = dictionary["overview"] as? String ?? "No Overview"
        releaseDate = dictionary["release_date"] as? String ?? "Release Date Unknown"
        if let backdropString = dictionary[Keys.backdropPath] as? String{
            let baseUrl = Keys.baseURL
            backdropURL = URL(string: baseUrl + backdropString)!
        }
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
