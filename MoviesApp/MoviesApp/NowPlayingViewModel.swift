//
//  GeneralScreenMovies.swift
//  MoviesApp
//
//  Created by Victor S Melo on 08/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation

public class NowPlayingViewModel {
    
    let view: NowPlayingViewController
    
    var nowPlayingMovies: [Movie]
    var alphabet: [Character]
    
    init(view: NowPlayingViewController, isNowPlayingList: Bool, countryCode: String) {
        
        self.nowPlayingMovies = []
        self.alphabet = []
        self.view = view
        
        if(isNowPlayingList){
        
            TmdbAPIAccess.getNowPlayingMovies(countryCode: countryCode){(movies) in
                
                self.nowPlayingMovies.append(contentsOf: movies.sorted(by: { (movieA, movieB) -> Bool in
                    guard let titleA = movieA.title else {
                        return false
                    }
                    guard let titleB = movieB.title else {
                        return true
                    }
                    return titleA.compare(titleB).rawValue < 0
                }))
                
                view.nowPlayingCollectionView.reloadData()
                
                var alphabet: [Character] = []
                for character in "ABCDEFGHIJKLMNOPQRSTUVXWYZ".characters {
                    alphabet.append(character)
                }
                self.alphabet = alphabet
                
                view.alphabetCollectionView.reloadData()

                
                
            }
            
        }else{
            
            TmdbAPIAccess.getUpcomingMovies(countryCode: countryCode){(movies) in
                
                self.nowPlayingMovies.append(contentsOf: movies.sorted(by: { (movieA, movieB) -> Bool in
                    guard let titleA = movieA.title else {
                        return false
                    }
                    guard let titleB = movieB.title else {
                        return true
                    }
                    return titleA.compare(titleB).rawValue < 0
                }))
                
                view.nowPlayingCollectionView.reloadData()
                
                var alphabet: [Character] = []
                for character in "ABCDEFGHIJKLMNOPQRSTUVXWYZ".characters {
                    alphabet.append(character)
                }
                self.alphabet = alphabet
                
                view.alphabetCollectionView.reloadData()
                
            }
        }
    
    }
}
