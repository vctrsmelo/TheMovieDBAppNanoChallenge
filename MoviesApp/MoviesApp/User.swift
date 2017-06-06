//
//  User.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation

public class User {
	
	var id: String
	var watchlist: Set<Movie>
	var movieTags: [Int:MovieTags]
	
	init(id: String, watchlist: Set<Movie> = [], movieTags: [Int:MovieTags] = [:]) {
		self.id = id
		self.watchlist = watchlist
		self.movieTags = movieTags
	}
	
}
