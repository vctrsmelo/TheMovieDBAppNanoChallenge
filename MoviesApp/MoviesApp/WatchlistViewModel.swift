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
	
	let watchlist: Set<Movie>
	let alphabet: [Character]
	
	
	init(user: User, view: WatchlistViewController) {
		self.view = view
		
		if let watchlist = user.watchlist {
			self.watchlist = watchlist
		} else {
			watchlist = []
		}
		
		var alphabet: [Character] = []
		for character in "ABCDEFGHIJKLMNOPQRSTUVXWYZ".characters {
			alphabet.append(character)
		}
		self.alphabet = alphabet
	}
	
	
}
