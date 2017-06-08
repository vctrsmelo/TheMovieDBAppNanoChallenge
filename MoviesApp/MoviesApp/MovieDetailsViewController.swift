//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var screenTitleTop: NSLayoutConstraint!
    @IBOutlet weak var screenTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewLeading: NSLayoutConstraint!
    @IBOutlet weak var tableViewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    var movie: Movie! = Movie(id: "166426", title: "Pirates of the Caribbean", originalTitle: "nenhum titulo original", genres: ["luz", "camera", "acao"], runtime: 145, releaseDateString: "2017-01-01", overview: "ooooi", poster: UIImage(named: "images"), videosURL: [], cast: [])
    var selection: String = "videos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.clear
        tableView.layer.shadowColor = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        tableView.layer.shadowOpacity = 0.95
        tableView.layer.shadowRadius = 6.0
        
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = .white
        
        DataManager.movie(id: "166426") { (movie) in
            if let newMovie = movie {
                self.movie = newMovie
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                screenTitleTop.constant     = 30
                screenTitleHeight.constant  = 25
                tableViewLeading.constant   = 46
                tableViewTrailing.constant  = 46
            } else {
                screenTitleTop.constant     = 47
                screenTitleHeight.constant  = 25
                tableViewLeading.constant   = 73
                tableViewTrailing.constant  = 73
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                switch indexPath.row {
                case 0:
                    return 176
                case 1:
                    return 456
                case 2:
                    return 200 // 137 + TODO
                case 3:
                    return 122
                case 4:
                    if selection == "videos" {
                        return 470
                    } else {
                        return 432
                    }
                case 5:
                    return 359
                default:
                    return 0
                }
            } else {
                switch indexPath.row {
                case 0:
                    return 209
                case 1:
                    return 594
                case 2:
                    return 220 // 149 + TODO
                case 3:
                    return 133
                case 4:
                    if selection == "videos" {
                        return 652
                    } else {
                        return 432
                    }
                case 5:
                    return 406
                default:
                    return 0
                }
            }
        } else {
            switch indexPath.row {
            case 0:
                return 113
            case 1:
                return 237
            case 2:
                return 132 // 72 + TODO
            case 3:
                return 63
            case 4:
                return 268
            case 5:
                return 258
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            cell.backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0)
            cell.backgroundColor = UIColor.white.withAlphaComponent(0)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
            
            cell.movieImage.image = movie.poster
            
            let index = movie.title?.index((movie.title?.startIndex)!, offsetBy: 4)
            cell.movieYear.text = movie.releaseDateString?.substring(to: index!)
            
            /*if let text = cell.movieTitle.attributedText?.string {
                let index = text.index((text.startIndex)!, offsetBy: text.length)
                cell.movieTitle.attributedText?.string.replaceSubrange(index, with: movie.title)
            }*/
            
            cell.movieGenre.text = movie.genres?.joined(separator: ", ")
            cell.movieTime.text = minutesToHoursString(minutes: movie.runtime!)
            
            if let movieTags = DataManager.user.movieTags[movie.id] {
                cell.isFavorite = movieTags.isFavorite
                cell.isWatched = movieTags.isOnWatchlist
                
                switch Int(movieTags.userRating) {
                case 1:
                    cell.oneStarPressed(UIButton(type: .custom))
                case 2:
                    cell.twoStarsPressed(UIButton(type: .custom))
                case 3:
                    cell.threeStarsPressed(UIButton(type: .custom))
                case 4:
                    cell.fourStarsPressed(UIButton(type: .custom))
                case 5:
                    cell.fiveStarsPressed(UIButton(type: .custom))
                default:
                    break
                }
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell") as! OverviewTableViewCell
            //cell.movieOverview.attributedText.string = movie.overview
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell") as! SelectionTableViewCell
            cell.root = self
            return cell
            
        case 4:
            if selection == "videos" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "videosCell") as! VideosTableViewCell
                cell.videosURL = movie.videosURL!
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "castingCell") as! CastingTableViewCell
                cell.cast = movie.cast!
                return cell
            }
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "recommendationsCell") as! RecommendationsTableViewCell
            
            // TODO
            cell.recommendedMovies = [Movie(id: "", title: "", originalTitle: "", genres: [], runtime: nil, releaseDateString: nil, overview: nil, poster: UIImage(named: "images")), Movie(id: "", title: "", originalTitle: "", genres: [], runtime: nil, releaseDateString: nil, overview: nil, poster: UIImage(named: "images")), Movie(id: "", title: "", originalTitle: "", genres: [], runtime: nil, releaseDateString: nil, overview: nil, poster: UIImage(named: "images"))]
            return cell
            
        default:
            return UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }
    }
    
    func minutesToHoursString(minutes: Int) -> String {
        let h = minutes / 60
        let m = minutes % 60
        return "\(h)h \(m)min"
    }
}
