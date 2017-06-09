//
//  Actor.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit


protocol ActorDelegate: class{
    
    func updatedPhotoImage(_ photoImage: UIImage?)

}

class Actor {
    var actorName: String = ""
    var characterName: String = ""
    var photo: UIImage?
    
    weak var delegate: ActorDelegate?
    
    func set(photo: UIImage){
        
        self.photo = photo
        delegate?.updatedPhotoImage(photo)
        
    }
    
    init() {
        
    }
    
    init(actorName: String, characterName: String, photo: UIImage?){
        
        self.actorName = actorName
        self.characterName = characterName
        self.photo = photo
        
    }
    
}
