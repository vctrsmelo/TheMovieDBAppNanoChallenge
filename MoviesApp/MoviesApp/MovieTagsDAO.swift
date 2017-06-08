//
//  MovieTagsDAO.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RealmDictionaryEntry : Object {
	dynamic var key = ""
	dynamic var movieTagsDAO : MovieTagsDAO?
	
	convenience init(key : String, movieTagsDAO: MovieTagsDAO) {
		self.init()
		
		self.key = key
		self.movieTagsDAO = movieTagsDAO
	}
}

class MovieTagsDAO: Object {
	dynamic var movieID = ""
	dynamic var isFavorite = false
	dynamic var isOnWatchlist = false
	dynamic var userRating : Float = 0.0
	dynamic var userWatchedPhoto : Data? = nil
	
	override static func primaryKey() -> String? {
		return "movieID"
	}
	
	convenience init(_ movieTags : MovieTags) {
		self.init()
		
		self.movieID = movieTags.movieID
		self.isFavorite = movieTags.isFavorite
		self.isOnWatchlist = movieTags.isOnWatchlist
		self.userRating = movieTags.userRating
		
		if let watchedPhoto = movieTags.userWatchedPhoto {
			self.userWatchedPhoto = UIImagePNGRepresentation(watchedPhoto)
		}
	}
	
	// MARK: Public Methods
	func intoMovieTags() -> MovieTags {
		
		var movieTagsDAOPhoto : UIImage? = nil
		
		if let movieTagsDAOPhotoData = self.userWatchedPhoto {
			movieTagsDAOPhoto = UIImage(data: movieTagsDAOPhotoData)
		}
		
		return MovieTags(movieID: self.movieID, isFavorite: self.isFavorite, isOnWatchlist: self.isOnWatchlist, userRating: self.userRating, userWatchedPhoto: movieTagsDAOPhoto)
	}
	
}
