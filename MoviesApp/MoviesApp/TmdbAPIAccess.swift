//
//  TMDBMoviesDTO.swift
//  ChallengeAPI
//
//  Created by Victor S Melo on 31/05/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import UIKit
class TmdbAPIAccess: NSObject {
    
    //API Key
    private static let apiKey = "7f5f382d2a06f7172d41b460a773743e"
    private static let imageStartingUrl = "http://image.tmdb.org/t/p/w185"
    
    override init(){
        
        super.init()
        
    }
    
    /*
     countryCode: acquired through the following code
     if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
     
     }
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

                            for movieDic in movies{
                                
                                if let movie = getMovieFrom(movieDictionary: movieDic){
                                    
                                    moviesArray.append(movie)
                                    
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
                            
                            for movieDic in movies{

                                if let movie = getMovieFrom(movieDictionary: movieDic){
                                
                                    moviesArray.append(movie)
                                
                                }
                            
                            }
                            
                        }
                        
                    }
                    
                    succeeded(moviesArray)
                    
                }catch let error{
                    
                    print(error)
                    
                }
                
                }.resume()
            
        }
        
    }
    
    public static func getMoviesBy(title: String, succeeded: @escaping ([Movie]) -> Void){
        
        var moviesArray : [Movie] = []
        
        //URL for the page 1 (most recent movies)
        print("language: \(Locale.preferredLanguages[0])")
        if let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key="+apiKey+"&language="+Locale.preferredLanguages[0]+"&query=+"+title) {
            
            let request = URLRequest(url: url)
            
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if let dic = json as? [String:AnyObject]{
                        
                        if let movies = dic["results"] as? [[String:AnyObject]]{
                            
                            for movieDic in movies{
                                
                                if let movie = getMovieFrom(movieDictionary: movieDic){
                                    
                                    //if parameter title is part of the movie title
                                    if let movieTitle = movie.title{
                                        
                                        if movieTitle.contains(title){
                                    
                                            moviesArray.append(movie)
                                        
                                        }
                                    
                                    }else if let movieOriginalTitle = movie.originalTitle{
                                        
                                        if movieOriginalTitle.contains(title){
                                            
                                            moviesArray.append(movie)
                                            
                                        }
                                        
                                    }
                                    
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
    
    public static func getMovieBy(id: CUnsignedLong, completion: @escaping (_ movie : Movie?) -> Void){
        
        if let url = URL(string:"http://api.themoviedb.org/3/movie/"+String(id)+"?api_key="+apiKey+"&language="+Locale.preferredLanguages[0]){

            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if let movieDic = json as? [String:AnyObject]{

                        completion(getMovieFrom(movieDictionary: movieDic))
                        
                    }
                    
                    
                } catch let error{
                    
                    print(error)
                    
                }
                
            }.resume()
            
        }
        
    }
    
    
    private static func getMovieFrom(movieDictionary movie: [String:AnyObject]) -> Movie?{
        
        var posterUrl: URL? = nil
        if let posterPath = movie["poster_path"] as? String{
            
            posterUrl = URL(string: imageStartingUrl+posterPath)
            
        }
        let id = movie["id"]
        let title = movie["title"]
        let originalTitle = movie["original_title"]
        let releaseDate = movie["release_date"]
        let overview = movie["overview"]
        let runtime = movie["runtime"]
        
        //get genres
        var genres : [String] = []
        if let genresJson = movie["genres"] as? [[String:AnyObject]]{
            
            for currentGenreJson in genresJson{
                
                if let genreName = currentGenreJson["name"] as? String{
                    
                    genres.append(genreName)
                    
                }
                
            }
            
        }
        
        let movie = Movie(id: "\(String(describing: id))", title: title as? String, originalTitle: originalTitle as? String, genres: genres, runtime: runtime as? Int, releaseDateString: releaseDate as? String, overview: overview as? String)
        
        if let url = posterUrl{
            
            TmdbAPIAccess.getImageFromUrl(url: url){(imageData, response, error) in
                
                if let data = imageData, let posterImage = UIImage(data:data){
                    
                    movie.set(poster: posterImage)
                    
                }
            }
            
        }
        
        return movie
        
    }
    
    
    public static func getImageFromUrl(url: URL, completion: @escaping (_ imageData: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {

        URLSession.shared.dataTask(with: url) {
            (imageData, response, error) in
            completion(imageData, response, error)
        
        }.resume()
        
    }
    
}
