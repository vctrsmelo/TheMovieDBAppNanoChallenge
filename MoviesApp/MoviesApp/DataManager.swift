//
//  DataManager.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 07/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation

class DataManager {
	static let user : User = UserDAO.load() ?? User.init(id: "Me")
	
//	static func upcomingMovies() -> [Movie] {
//		
//	}
//	
//	static func nowPlayingMovies() -> [Movie] {
//		
//	}
	
	static func movie(id : String, completion: @escaping (Movie?) -> Void) {
		//var movie : Movie? = nil
		
		
	}
	
//	static func movies(with title : String) -> [Movie] {
//		
//	}
//	
//	static func watchlistMovies() -> [Movie] {
//		
//	}
//	
//	static func update() -> Bool {
//		
//	}
}
