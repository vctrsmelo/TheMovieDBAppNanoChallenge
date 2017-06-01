//
//  Movie.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit.UIImage

public class Movie: Hashable, Equatable {
	
	public let id: String
	public let title: String?
	public let genre: [String]?
	public let poster: UIImage?
	public var hashValue: Int {
		return id.hashValue
	}
	
	init(id: String, title: String, genre: [String], poster: UIImage) {
		self.id = id
		self.title = title
		self.genre = genre
		self.poster = poster
	}
	
	public static func ==(lhs: Movie, rhs: Movie) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
