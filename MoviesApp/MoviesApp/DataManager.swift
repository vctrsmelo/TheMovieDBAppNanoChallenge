//
//  DataManager.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 07/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import os.log

class DataManager {
	static let user : User = {
		var result : User
		
		if let theResult : User = UserDAO.load() {
			result = theResult
		} else {
			result = User(id: "Me")
			if !UserDAO.save(result) {
				os_log("Unable to save new User", log: OSLog.default, type: .error)
				fatalError()
			}
		}
		
		return result
	}()
	static let countryCode = ((Locale.current as NSLocale).object(forKey: .countryCode) as? String) ?? "en-US"
	
	static func upcomingMovies(completion: @escaping ([Movie]) -> Void) {
		TmdbAPIAccess.getUpcomingMovies(countryCode: countryCode) { (movies) in
			completion(movies)
		}
	}
	
	static func nowPlayingMovies(completion: @escaping ([Movie]) -> Void) {
		TmdbAPIAccess.getNowPlayingMovies(countryCode: countryCode) { (movies) in
			completion(movies)
		}
	}
	
	static func movie(id : String, completion: @escaping (Movie?) -> Void) {
		
		if let movie : Movie = MovieDAO.load(id: id) {
			completion(movie)
		} else {
			
			TmdbAPIAccess.getMovieBy(id: id, completion: { (movie) in
				var result : Movie? = movie
				
				if result != nil {
					if !MovieDAO.save(result!) {
						result = nil
					}
				}
				
				completion(result)
				
			})
			
		}

	}
	
	static func movies(with title : String, completion: @escaping ([Movie]) -> Void) {
		TmdbAPIAccess.getMoviesBy(title: title) { (movies) in
			completion(movies)
		}
	}
	
	static func watchlistMovies() -> [Movie] {
		return MovieDAO.load(ids: user.watchlist)
	}

	static func update() -> Bool {
		return UserDAO.update(user)
	}
}
