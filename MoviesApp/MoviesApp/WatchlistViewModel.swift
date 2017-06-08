//
//  WatchlistModel.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation

public class WatchlistViewModel {
	
	let view: WatchlistViewController
	
	let watchlist: [Movie]
	let alphabet: [Character]
	
	init(user: User, view: WatchlistViewController) {
		self.view = view

		self.watchlist = Array(DataManager.watchlistMovies()).sorted(by: { (movieA, movieB) -> Bool in
			guard let titleA = movieA.title else {
				return false
			}
			guard let titleB = movieB.title else {
				return true
			}
			return titleA.compare(titleB).rawValue < 0
		})
		
		var alphabet: [Character] = []
		for character in "ABCDEFGHIJKLMNOPQRSTUVXWYZ".characters {
			alphabet.append(character)
		}
		self.alphabet = alphabet
	}
}
