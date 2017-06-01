//
//  ViewController.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get recent movies
        TmdbAPIAccess.getNowPlayingMovies(countryCode: "BR"){(moviesArray) in
            
            print("v0")
            //self.movies = moviesArray
            //self.refreshUI()
            
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

