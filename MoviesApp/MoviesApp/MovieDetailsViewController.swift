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
    var selection: String = "videos"
    var movie : Movie?
	
	var testBoolForPhoto = false
	let testID = "123456"
	private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.clear
        tableView.layer.shadowColor = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        tableView.layer.shadowOpacity = 0.95
        tableView.layer.shadowRadius = 6.0
		
		configureImagePicker()
        
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.reloadData()
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                screenTitleTop.constant                         = 30
                screenTitleHeight.constant                      = 25
                tableViewLeading.constant                       = 46
                tableViewTrailing.constant                      = 46
            } else {
                screenTitleTop.constant                         = 47
                screenTitleHeight.constant                      = 25
                tableViewLeading.constant                       = 73
                tableViewTrailing.constant                      = 73
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainInformationsCell", for: indexPath) as! MainInformationsTableViewCell

            if let movie = self.movie{
                
                let title = movie.title ?? "No Title"
                
                let attributes = cell.movieTitle.attributedText?.attributes(at: 0, effectiveRange: nil)
                
                let cellTitle = NSMutableAttributedString.init(string: title, attributes: attributes)
                
                cell.movieTitle.attributedText = cellTitle
                
            }
            
            cell.root = self
    
            return cell
            
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! OverviewTableViewCell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath) as! SelectionTableViewCell
            cell.root = self
            return cell
            
        case 4:
            if selection == "videos" {
                return tableView.dequeueReusableCell(withIdentifier: "videosCell", for: indexPath) as! VideosTableViewCell
            } else {
                return tableView.dequeueReusableCell(withIdentifier: "castingCell", for: indexPath) as! CastingTableViewCell
            }
            
        case 5:
            return tableView.dequeueReusableCell(withIdentifier: "recommendationsCell", for: indexPath) as! RecommendationsTableViewCell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "mainInformationsCell", for: indexPath) as! MainInformationsTableViewCell

        }
    }
	
	// MARK: Image Picker Methods
	private func configureImagePicker() {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .camera
		imagePicker.navigationController?.delegate = self
	}
	
	internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage {
			// TODO: Correct ID
			DataManager.user.watchedMovie(id: self.testID, photo: photo)
			self.testBoolForPhoto = true
		} else {
			self.testBoolForPhoto = false
		}
	}
	
	public func presentImagePicker() {
		present(imagePicker, animated: true, completion: nil)
	}
}
