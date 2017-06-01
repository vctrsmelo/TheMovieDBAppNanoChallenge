//
//  RealmsConfig.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import RealmSwift

class RealmsConfig {
	// MARK: Private Properties
	static private let instance = RealmsConfig()
	private let defaultRealm : Realm
	private let temporaryRealm : Realm
	
	// MARK: Initializer
	private init(){
		defaultRealm = try! Realm()
		temporaryRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "InMemoryMovie"))
	}
	
	// MARK: Public Methods
	static func getDefaultRealm() -> Realm {
		return instance.defaultRealm
	}
	
	static func getTemporaryRealm() -> Realm {
		return instance.temporaryRealm
	}
}
