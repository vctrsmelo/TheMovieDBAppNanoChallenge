//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // Main view
    @IBOutlet weak var screenTitleTop: NSLayoutConstraint!
    @IBOutlet weak var screenTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewLeading: NSLayoutConstraint!
    @IBOutlet weak var tableViewTrailing: NSLayoutConstraint!
    
    // Main Informations
    
    // Overview
    @IBOutlet weak var overviewLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var overviewLabelTop: NSLayoutConstraint!
    @IBOutlet weak var overviewLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var overviewLabelTrailing: NSLayoutConstraint!
    @IBOutlet weak var movieOverviewTop: NSLayoutConstraint!
    @IBOutlet weak var movieOverviewBottom: NSLayoutConstraint!
    
    // Selection
    @IBOutlet weak var selectionButtonsHeight: NSLayoutConstraint!
    @IBOutlet weak var selectionButtonsTop: NSLayoutConstraint!
    
    // Videos
    @IBOutlet weak var videosCellHeight: NSLayoutConstraint!
    @IBOutlet weak var videosCellTop: NSLayoutConstraint!
    
    // Casting
    @IBOutlet weak var castingCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var actorNameLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var characterNameLabelHeight: NSLayoutConstraint!
    
    // Recommendations
    @IBOutlet weak var recommendationsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendationsLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var recommendationsLabelTrailing: NSLayoutConstraint!
    @IBOutlet weak var recommendationsLabelBottom: NSLayoutConstraint!
    
    
    @IBOutlet weak var tableView: UITableView!
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
                // Main view
                screenTitleTop.constant                         = 30
                screenTitleHeight.constant                      = 25
                tableViewLeading.constant                       = 46
                tableViewTrailing.constant                      = 46
                
                // Main Informations
                
                // Overview
                overviewLabelHeight.constant                    = 25
                overviewLabelTop.constant                       = 42
                overviewLabelLeading.constant                   = 42 // Leading de todas as views
                overviewLabelTrailing.constant                  = 48 // Trailing ''
                movieOverviewTop.constant                       = 30
                movieOverviewBottom.constant                    = 40
                
                // Selection
                selectionButtonsHeight.constant                 = 4
                selectionButtonsTop.constant                    = 17
                
                // Videos
                videosCellHeight.constant                       = 346
                videosCellTop.constant                          = 84
                
                // Casting
                castingCollectionViewHeight.constant            = 241
                actorNameLabelHeight.constant                   = 26
                characterNameLabelHeight.constant               = 18
                
                // Recommendations
                recommendationsCollectionViewHeight.constant    = 258
                recommendationsLabelLeading.constant            = 42 // Leading de todas as views
                recommendationsLabelTrailing.constant           = 48 // Trailing de todas as views
                recommendationsLabelBottom.constant             = 45
                
            } else {
                // Main view
                screenTitleTop.constant                         = 47
                screenTitleHeight.constant                      = 25
                tableViewLeading.constant                       = 73
                tableViewTrailing.constant                      = 73
                
                // Main Informations
                
                // Overview
                overviewLabelHeight.constant                    = 25
                overviewLabelTop.constant                       = 50
                overviewLabelLeading.constant                   = 57 // Leading de todas as views
                overviewLabelTrailing.constant                  = 63 // Trailing de todas as views
                movieOverviewTop.constant                       = 25
                movieOverviewBottom.constant                    = 43
                
                // Selection
                selectionButtonsHeight.constant                 = 5
                selectionButtonsTop.constant                    = 2
                
                // Videos
                videosCellHeight.constant                       = 450
                videosCellTop.constant                          = 109
                
                // Casting
                castingCollectionViewHeight.constant            = 241
                actorNameLabelHeight.constant                   = 26
                characterNameLabelHeight.constant               = 18
                
                // Recommendations
                recommendationsCollectionViewHeight.constant    = 258
                recommendationsLabelLeading.constant            = 57 // Leading de todas as views
                recommendationsLabelTrailing.constant           = 63 // Trailing de todas as views
                recommendationsLabelBottom.constant             = 62
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
                    return 200 // TODO
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
                    return 212 // TODO
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
                return 132 // TODO
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
            return tableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
            
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "overviewCell") as! OverviewTableViewCell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell") as! SelectionTableViewCell
            cell.root = self
            return cell
            
        case 4:
            if selection == "videos" {
                return tableView.dequeueReusableCell(withIdentifier: "videosCell") as! VideosTableViewCell
            } else {
                return tableView.dequeueReusableCell(withIdentifier: "castingCell") as! CastingTableViewCell
            }
            
        case 5:
            return tableView.dequeueReusableCell(withIdentifier: "recommendationsCell") as! RecommendationsTableViewCell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
        }
    }
}
