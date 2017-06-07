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
	let cast = List<ActorDAO>()
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience init(_ movie : Movie) {
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
		
		if let movieCast = movie.cast {
			for actor in movieCast {
				self.cast.append(ActorDAO(actor))
			}
		}
	}
	
	// MARK: Public Methods
	func intoMovie() -> Movie {
		var movieGenres : [String]? = nil
		
		if !self.genres.isEmpty {
			movieGenres = [String]()
			for genre in self.genres {
				movieGenres?.append(genre.value)
			}
		}
		
		var moviePoster : UIImage? = nil
		if let movieDAOPosterData = self.poster {
			moviePoster = UIImage(data: movieDAOPosterData)
		}
		
		var movieCast : [Actor]? = nil
		if !self.cast.isEmpty {
			movieCast = [Actor]()
			for actorDAO in self.cast {
				movieCast?.append(actorDAO.intoActor())
			}
		}
		
		return Movie(id: self.id, title: self.title, originalTitle: self.originalTitle, genres: movieGenres, runtime: self.runtime.value, releaseDateString: self.releaseDateString, overview: self.overview, poster: moviePoster, cast: movieCast)
	}
	
	static func save(_ movie : Movie) -> Bool {
		let movieDAO = MovieDAO(movie)
		
		return RealmsConfig.save(movieDAO, update: false, temporary: true)
	}
	
//	static func update(_ movie : Movie) -> Bool {
//		let movieDAO = MovieDAO(movie)
//		
//		return RealmsConfig.save(movieDAO, update: true, temporary: true)
//	}
	
	static func load(id : String) -> MovieDAO? {
		return RealmsConfig.load(MovieDAO.self, with: id)
	}
	
	static func load(id : String) -> Movie? {
		let movieDAO = RealmsConfig.load(MovieDAO.self, with: id)
		
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
