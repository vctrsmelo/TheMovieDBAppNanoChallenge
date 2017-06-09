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
    var upcomingMovies: [Movie]
    var alphabet: [Character]
    
    init(view: NowPlayingViewController, isNowPlayingList: Bool, countryCode: String) {
        
        self.nowPlayingMovies = []
        self.upcomingMovies = []
        self.alphabet = []
        self.view = view
        
        isNowPlayingList ? getNowPlayingMovies(countryCode: countryCode) : getUpcomingMovies(countryCode: countryCode)
    
    }
    
    func getUpcomingMovies(countryCode: String){
        
        TmdbAPIAccess.getUpcomingMovies(countryCode: countryCode){(movies) in
            
            self.view.nowPlayingCollectionView.isHidden = true
            self.view.alphabetCollectionView.isHidden = true
            
            self.upcomingMovies.append(contentsOf: movies.sorted(by: { (movieA, movieB) -> Bool in
                guard let titleA = movieA.title else {
                    return false
                }
                guard let titleB = movieB.title else {
                    return true
                }
                return titleA.compare(titleB).rawValue < 0
            }))
            
            self.view.nowPlayingCollectionView.reloadData()
            
            var alphabet: [Character] = []
            for character in "ABCDEFGHIJKLMNOPQRSTUVXWYZ".characters {
                alphabet.append(character)
            }
            self.alphabet = alphabet
            
            self.view.alphabetCollectionView.reloadData()
            
            self.view.nowPlayingCollectionView.isHidden = false
            self.view.alphabetCollectionView.isHidden = false
            
        }

        
    }
    
    func getNowPlayingMovies(countryCode: String){
        
        TmdbAPIAccess.getNowPlayingMovies(countryCode: countryCode){(movies) in
            
            self.view.nowPlayingCollectionView.isHidden = true
            self.view.alphabetCollectionView.isHidden = true
            
            self.nowPlayingMovies.append(contentsOf: movies.sorted(by: { (movieA, movieB) -> Bool in
                guard let titleA = movieA.title else {
                    return false
                }
                guard let titleB = movieB.title else {
                    return true
                }
                return titleA.compare(titleB).rawValue < 0
            }))
            
            self.view.nowPlayingCollectionView.reloadData()
            
            var alphabet: [Character] = []
            for character in "ABCDEFGHIJKLMNOPQRSTUVXWYZ".characters {
                alphabet.append(character)
            }
            self.alphabet = alphabet
            
            self.view.alphabetCollectionView.reloadData()
            
            self.view.nowPlayingCollectionView.isHidden = false
            self.view.alphabetCollectionView.isHidden = false
            
        }
        
    }
    
    
}
