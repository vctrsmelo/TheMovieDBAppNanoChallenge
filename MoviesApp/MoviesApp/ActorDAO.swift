//
//  ActorDAO.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 07/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ActorDAO: Object {
	dynamic var id = UUID().uuidString
	dynamic var actorName = ""
	dynamic var characterName = ""
	dynamic var photo : Data? = nil
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience init(_ actor : Actor) {
		self.init()
		
		self.actorName = actor.actorName
		self.characterName = actor.characterName
		
		if let actorPhoto = actor.photo {
			self.photo = UIImagePNGRepresentation(actorPhoto)
		}
	}
	
	// MARK: Public Methods
	func intoActor() -> Actor {
		var actorDAOPhoto : UIImage? = nil
		
		if let actorDAOPhotoData = self.photo {
			actorDAOPhoto = UIImage(data: actorDAOPhotoData)
		}
		
		return Actor(actorName: self.actorName, characterName: self.characterName, photo: actorDAOPhoto)
	}
}
