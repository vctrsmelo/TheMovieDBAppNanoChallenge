//
//  TMDBMoviesDTO.swift
//  ChallengeAPI
//
//  Created by Victor S Melo on 31/05/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

// TODO: delete this Movie class
class Movie{
    
    init(title: String, posterImage: UIImage) {
        
    }
    
}

import UIKit
class TmdbAPIAccess: NSObject {
    
    //API Key
    private static let apiKey = "7f5f382d2a06f7172d41b460a773743e"
    private static let imageStartingUrl = "http://image.tmdb.org/t/p/w185"
    
    override init(){
        
        super.init()
        
    }
    
    /*
     page: indicates the page of movies. Page 1 are the most recent movies.
     */
    public static func getNowPlayingMovies(countryCode: String, succeeded: @escaping ([Movie]) -> Void){
    
        var moviesArray : [Movie] = []
    
        //URL for the page 1 (most recent movies)        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key="+apiKey+"&region="+countryCode) {
        
            let request = URLRequest(url: url)
            
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
 
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if let dic = json as? [String:AnyObject]{

                        if let movies = dic["results"] as? [[String:AnyObject]]{

                            for movie in movies{

                                if let movieDic = movie as? [String:AnyObject]{
                                    
                                    moviesArray.append(getMovieFrom(movieDictionary: movieDic))
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    succeeded(moviesArray)
                    
                } catch let error{
                    
                    print(error)
                    
                }
                
            }.resume()
            
        }
        
    }
    
    public static func getUpcomingMovies(countryCode: String, succeeded: @escaping ([Movie]) -> Void){
        
        var moviesArray : [Movie] = []

        //URL for the page 1 (most recent movies)
        if let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key="+apiKey+"&region="+countryCode) {
        
            let request = URLRequest(url: url)
            
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if let dic = json as? [String:AnyObject]{
                        
                        if let movies = dic["results"] as? [[String:AnyObject]]{
                            
                            for movie in movies{

                                if let movieDic = movie as? [String:AnyObject]{
                                
                                    moviesArray.append(getMovieFrom(movieDictionary: movieDic))
                                
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    succeeded(moviesArray)
                    
                } catch let error{
                    
                    print(error)
                    
                }
                
                }.resume()
            
        }
        
    }
    
    private static func getMovieFrom(movieDictionary movie: [String:AnyObject]) -> Movie{
    
        let title = movie["title"]
        let releaseDateString : String = movie["release_date"] as! String
        let posterUrl = imageStartingUrl+(movie["poster_path"] as! String)
        let overview = movie["overview"]
        let runtime = movie["runtime"]
        
        // TODO: get genres
    
        return nil
    
    }
    
    public static func getMovieBy(title: String, succeeded: @escaping ([Movie]) -> Void){
        
        
        
    }
    
    public static func getMovieBy(id: CUnsignedLong, succeeded: @escaping ([Movie]) -> Void){
        
        if let url = URL(string:"http://api.themoviedb.org/3/movie/157336?api_key="+(id as? String)){
            
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if let movie = json as? [String:AnyObject]{
                
                        moviesArray.append(getMovieFrom(movieDictionary: movie))
                        
                    }
                    
                    succeeded(moviesArray)
                    
                } catch let error{
                    
                    print(error)
                    
                }
                
            }.resume()
            
        }
        
    }
    
    
    
}
