//
//  UserDAO.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import RealmSwift

class UserDAO : Object {
	dynamic var id = ""
	let watchlist = List<MovieDAO>()
	let movieTags = List<RealmDictionaryEntry>()
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	private convenience init(_ user : User) {
		self.init()
		
		self.id = user.id
		
		for movieID in user.watchlist {
			if let movieDAO : MovieDAO = MovieDAO.load(id: movieID) {
				self.watchlist.append(movieDAO)
			}
		}
		
		for (movieID, movieTags) in user.movieTags {
			let movieTagsDAO = MovieTagsDAO(movieTags)
			
			self.movieTags.append(RealmDictionaryEntry(key: movieID, value: movieTagsDAO))
		}
		
	}
	
	// MARK: Private Methods
	private func intoUser() -> User {
		var watchlist = Set<String>()
		var movieTags = [String : MovieTags]()
		
		for movie in self.watchlist {
			watchlist.insert(movie.intoMovie().id)
		}
		
		for dictionaryEntry in self.movieTags {
			
			movieTags[dictionaryEntry.key] = (dictionaryEntry.value as! MovieTagsDAO).intoMovieTags()
		}
		
		return User(id: self.id, watchlist: watchlist, movieTags: movieTags)
	}
	
	// MARK: Public Methods
	static func save(_ user : User) -> Bool {
		let userDAO = UserDAO(user)
		
		return RealmsConfig.save(userDAO, update: false, temporary: false)
	}
	
	static func update(_ user : User) -> Bool {
		let userDAO = UserDAO(user)
		
		return RealmsConfig.save(userDAO, update: true, temporary: false)
	}
	
	static func load() -> User? {
		
		return (RealmsConfig.load(UserDAO.self).first as? UserDAO)?.intoUser()
	}
}
