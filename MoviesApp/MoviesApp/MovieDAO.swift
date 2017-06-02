//
//  MovieDAO.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import RealmSwift

class MovieDAO : Object {
	static private let instance = MovieDAO()
	dynamic var id = ""
	dynamic var title = ""
	dynamic var releaseYear = 0
	dynamic var genre = ""
	
	override static func ignoredProperties() -> [String] {
		return ["instance"]
	}
	
	// MARK: Private Methods
	private func intoMovie() -> Any {
		// TODO: Everything
		return self
	}
	
	// MARK: Public Methods
	static func getMovie(id : String) -> Any? {
		let movieDAO = RealmsConfig.getTemporaryRealm().objects(MovieDAO.self).filter("id == \(id)").first
		
		return movieDAO?.intoMovie()
	}
	
	static func getMovies() {
		let movies = RealmsConfig.getTemporaryRealm().objects(MovieDAO.self)
		
		//return movies
	}
}
