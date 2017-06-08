//
//  MovieTags.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

public struct MovieTags {
	let movieID: String
	var isFavorite: Bool
	var isOnWatchlist: Bool
	var userRating: Float
	var userWatchedPhoto: UIImage?
}
