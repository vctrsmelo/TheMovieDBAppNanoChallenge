//
//  Actor.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class Actor {
    let actorName: String?
    let characterName: String?
    var photo: UIImage?
    
    init(actorName: String, characterName: String, photo: UIImage? = nil) {
        self.actorName = actorName
        self.characterName = characterName
        self.photo = photo
    }
}
