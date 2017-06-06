//
//  Movie.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol MovieDelegate: class{
    
    func updatedPosterImage(_ posterImage: UIImage?)
    
}

public class Movie: Hashable, Equatable {
	
	public let id: String
	public let title: String?
    public let originalTitle: String?
	public let genres: [String]?
	public var poster: UIImage?
    public let runtime: Int?
    public let overview: String?
    public let releaseDateString: String?
    let cast: [Actor]?
    
	public var hashValue: Int {
		return id.hashValue
	}
    
    weak var delegate: MovieDelegate?

    init(id: String, title: String?, originalTitle: String?, genres: [String]?, runtime: Int?, releaseDateString: String?, overview: String?, poster: UIImage? = nil) {
		self.id = id
		self.title = title
		self.genres = genres
		self.poster = poster
        self.runtime = runtime
        self.releaseDateString = releaseDateString
        self.overview = overview
        self.originalTitle = originalTitle
        self.cast = []
	}
    
    public func set(poster: UIImage){
        
        self.poster = poster
        delegate?.updatedPosterImage(self.poster)
        
    }
    
	public static func ==(lhs: Movie, rhs: Movie) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
