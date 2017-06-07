//
//  UIApplicationExtension.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 07/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
