//
//  MovieTags.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation

public struct MovieTags {
	let user: User
	let movie: Movie
	var isFavorite: Bool
	var isOnWatchlist: Bool {
		if let watchlist = user.watchlist {
			return watchlist.contains(movie)
		}
		return false
	}
	var userRating: Float
}
