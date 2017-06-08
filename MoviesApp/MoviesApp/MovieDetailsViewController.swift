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
                screenTitleTop.constant             = 30
                screenTitleHeight.constant          = 25
                tableViewLeading.constant           = 46
                tableViewTrailing.constant          = 46
                
                overviewLabelHeight.constant        = 25
                overviewLabelTop.constant           = 42
                overviewLabelLeading.constant       = 42 // Leading de todas as views
                overviewLabelTrailing.constant      = 48 // Trailing ''
                movieOverviewTop.constant           = 30
                movieOverviewBottom.constant        = 40
                
                selectionButtonsHeight.constant     = 4
                selectionButtonsTop.constant        = 17
                
                videosCellHeight.constant           = 346
                videosCellTop.constant              = 84
                
                castingCollectionViewHeight.constant= 241
                actorNameLabelHeight.constant       = 26
                characterNameLabelHeight.constant   = 18
                
            } else {
                screenTitleTop.constant             = 47
                screenTitleHeight.constant          = 25
                tableViewLeading.constant           = 73
                tableViewTrailing.constant          = 73
                
                overviewLabelHeight.constant        = 25
                overviewLabelTop.constant           = 50
                overviewLabelLeading.constant       = 57 // Leading de todas as views
                overviewLabelTrailing.constant      = 63 // Trailing ''
                movieOverviewTop.constant           = 25
                movieOverviewBottom.constant        = 43
                
                selectionButtonsHeight.constant     = 5
                selectionButtonsTop.constant        = 2
                
                videosCellHeight.constant           = 450
                videosCellTop.constant              = 109
                
                castingCollectionViewHeight.constant= 241
                actorNameLabelHeight.constant       = 26
                characterNameLabelHeight.constant   = 18
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 113
        case 1:
            return 237
        case 2:
            return 132
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
