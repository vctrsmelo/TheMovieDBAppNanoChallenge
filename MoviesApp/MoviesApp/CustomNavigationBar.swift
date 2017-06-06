//
//  CustomNavigationBar.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationBar: UINavigationBar {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
	}
	
}
