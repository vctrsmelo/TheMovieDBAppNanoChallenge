//
//  RealmsConfig.swift
//  MoviesApp
//
//  Created by Rodrigo Cardoso Buske on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import os.log
import RealmSwift

class RealmDictionaryEntry : Object {
	dynamic var key = 0
	dynamic var value : Object?
	
	convenience init(key : AnyHashable, value: Object) {
		self.init()
		
		self.key = key.hashValue
		self.value = value
	}
}

class RealmString : Object {
	dynamic var value = ""
	
	convenience init(_ value : String) {
		self.init()
		
		self.value = value
	}
}

class RealmsConfig {
	// MARK: Private Properties
	private static let inMemoryID = "InMemoryRealm"
	
	static private let instance = RealmsConfig()
	
	private var defaultRealm : Realm!
	private var temporaryRealm : Realm!
	
	// MARK: Initializer
	private init(){
		do {
			
			try self.getRealms()
			
		} catch let error as NSError {
			os_log("Error opening Realm", log: OSLog.default, type: .error)
			
			if error.code == 10 {
				// TODO: Make migration before releasing
				os_log("Migration required, instead, deleting database to be restarted", log: OSLog.default, type: .debug)
				
				let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
				let realmURLs = [
					realmURL,
					realmURL.appendingPathExtension("lock"),
					realmURL.appendingPathExtension("note"),
					realmURL.appendingPathExtension("management")
				]
				
				for URL in realmURLs {
					do {
						try FileManager.default.removeItem(at: URL)
					} catch {
						os_log("Error deleting database, try doing manually", log: OSLog.default, type: .debug)
					}
				}
				do {
					try self.getRealms()
				} catch {
					os_log("Error opening Realm again", log: OSLog.default, type: .error)
					fatalError()
				}
				
			} else {
				os_log("Unidentified error", log: OSLog.default, type: .error)
				fatalError()
			}
			
		}
	}
	
	// MARK: Private Methods
	private func getRealms() throws {
		self.defaultRealm = try Realm()
		self.temporaryRealm = try Realm(configuration: Realm.Configuration(inMemoryIdentifier: RealmsConfig.inMemoryID))
	}
		
	// MARK: Public Methods
	static func save(_ object : Object, update : Bool, temporary : Bool = false) -> Bool {
		var result = false
		
		let realm = temporary ? instance.temporaryRealm! : instance.defaultRealm!
		
		try! realm.write {
			realm.add(object, update: update)
			result = true
		}
		
		return result
	}
	
	static func load<KeyType, Obj : Object>(_ objectType : Obj.Type, with key : KeyType) -> Obj? {
		var result : Object? = nil
		
		
		result = instance.temporaryRealm.object(ofType: objectType, forPrimaryKey: key)
		
		if result == nil {
			result = instance.defaultRealm.object(ofType: objectType, forPrimaryKey: key)
		}
		
		return (result as! Obj)
	}
	
	static func load(_ objectType : Object.Type, with filter : NSPredicate? = nil) -> Results<Object> {
		var results : Results<Object>
		
		results = instance.temporaryRealm.objects(objectType)
		
		if filter != nil {
			results = results.filter(filter!)
		}
		
		if results.isEmpty {
			results = instance.defaultRealm.objects(objectType)
			
			if filter != nil {
				results = results.filter(filter!)
			}
		}
		
		return results
	}
}
