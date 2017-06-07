//
//  MovieDAO.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class MovieDAO : Object {
	dynamic var id = ""
	dynamic var title : String? = nil
	dynamic var originalTitle : String? = nil
	let genres = List<RealmString>()
	dynamic var poster : Data? = nil
	let runtime = RealmOptional<Int>()
	dynamic var overview : String? = nil
	dynamic var releaseDateString : String? = nil
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	private convenience init(_ movie : Movie) {
		self.init()
		
		self.id = movie.id
		self.title = movie.title
		self.originalTitle = movie.originalTitle
		
		if let movieGenres = movie.genres {
			for genre in movieGenres {
				self.genres.append(RealmString(genre))
			}
		}
		
		if let moviePoster = movie.poster {
			self.poster = UIImagePNGRepresentation(moviePoster)
		}
		
		self.runtime.value = movie.runtime
		self.overview = movie.overview
		self.releaseDateString = movie.releaseDateString
	}
	
	// MARK: Private Methods
	private func intoMovie() -> Movie {
		var movieDAOGenres : [String]? = nil
		
		if !self.genres.isEmpty {
			movieDAOGenres = [String]()
			for genre in self.genres {
				movieDAOGenres?.append(genre.value)
			}
		}
		
		var movieDAOPoster : UIImage? = nil
		if let movieDAOPosterData = self.poster {
			movieDAOPoster = UIImage(data: movieDAOPosterData)
		}
		
		return Movie(id: self.id, title: self.title, originalTitle: self.originalTitle, genres: movieDAOGenres, runtime: self.runtime.value, releaseDateString: self.releaseDateString, overview: self.overview, poster: movieDAOPoster)
	}
	
	// MARK: Public Methods
	static func save(_ movie : Movie, temporary : Bool) -> Bool {
		let movieDAO = MovieDAO(movie)
		
		return RealmsConfig.save(movieDAO, update: false, temporary: temporary)
	}
	
	static func update(_ movie : Movie, temporary : Bool) -> Bool {
		let movieDAO = MovieDAO(movie)
		
		return RealmsConfig.save(movieDAO, update: true, temporary: temporary)
	}
	
	static func load(id : String) -> Movie? {
		let movieDAO = RealmsConfig.load(MovieDAO.self, with: id) as? MovieDAO
		
		return movieDAO?.intoMovie()
	}
	
	static func load(filter : NSPredicate? = nil) -> [Movie] {
		let results = RealmsConfig.load(MovieDAO.self, with: filter)
		var movies = [Movie]()
		
		for result in results {
			if let movieDAO = result as? MovieDAO {
				movies.append(movieDAO.intoMovie())
			}
		}
		
		return movies
	}
}
