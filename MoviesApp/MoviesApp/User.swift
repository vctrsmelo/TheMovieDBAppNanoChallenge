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
	var watchlist: Set<String>
	var movieTags: [String:MovieTags]
	
	init(id: String, watchlist: Set<String> = [], movieTags: [String:MovieTags] = [:]) {
		self.id = id
		self.watchlist = watchlist
		self.movieTags = movieTags
	}
	
}
