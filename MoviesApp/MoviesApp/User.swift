//
//  User.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit.UIImage

public class User {
	
	var id: String
	private var _watchlist: Set<String>
	private var _movieTags: [String:MovieTags]
	
	var watchlist : Set<String> {
		return self._watchlist
	}
	
	var movieTags : [String:MovieTags] {
		return self._movieTags
	}
	
	init(id: String, watchlist: Set<String> = [], movieTags: [String:MovieTags] = [:]) {
		self.id = id
		self._watchlist = watchlist
		self._movieTags = movieTags
	}
	
	func watchedMovie(id : String, photo : UIImage) {
		
		if var localMovieTags = self.movieTags[id] {
			localMovieTags.userWatchedPhoto = photo
			self.addToWatchlist(id: id)
		} else {
			let localMovieTags = MovieTags(movieID: id, isFavorite: false, isOnWatchlist: true, userRating: 0.0, userWatchedPhoto: photo)
			self.addMovieTag(movieTags: localMovieTags)
			self.addToWatchlist(id: id)
		}
	}
	
	func removeWatchedMovie(id : String) {
		self._watchlist.remove(id)
		self._movieTags[id]?.isOnWatchlist = false
		self._movieTags[id]?.userWatchedPhoto = nil
	}
	
	private func addMovieTag(movieTags : MovieTags) {
		self._movieTags[movieTags.movieID] = movieTags
	}
	
	private func addToWatchlist(id : String) {
		if var movieTag = self.movieTags[id] {
			movieTag.isOnWatchlist = true
			self._watchlist.insert(id)
		}
	}
}
