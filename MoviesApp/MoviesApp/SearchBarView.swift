//
//  SearchBarView.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 08/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SearchBarView: UIView {
	
	private let nibName = "SearchBarView"
	
	var view: UIView!
	
	@IBOutlet weak var mainView: UIView!
	
	@IBOutlet weak var searchBarView: UISearchBar!
	
	var isToggledOn: Bool = false {
		didSet {
			print("didset: \(isToggledOn)")
			print(self.frame)
			
			if (isToggledOn) {
				UIApplication.shared.statusBarStyle = .lightContent
			}
			
			UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
				self.view.frame.origin.y = self.isToggledOn ? 0 : -64
			}, completion: {(bool) in
				UIApplication.shared.statusBarStyle = self.isToggledOn ? .lightContent : .default
			})
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
		paintSearchBarButton()
		toggleBar(on: false, animated: false)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
		paintSearchBarButton()
		toggleBar(on: false, animated: false)
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let hitView = super.hitTest(point, with: event)
		if (hitView == self) {
			return nil
		}
		return hitView
	}
	
	private func paintSearchBarButton() {
		for view in searchBarView.subviews[0].subviews {
			if let button = view as? UIButton {
				button.tintColor = .white
			}
		}
	}
	
	public func toggleBar(on: Bool, animated: Bool) { // Oy, ignore this
		print(on)
		if (on) {
			UIApplication.shared.statusBarStyle = .lightContent
		}
		let moveBar = { () in
			self.view.frame.origin.y = on ? 0 : -64
		}
		let changeStatusBar = { () in
			UIApplication.shared.statusBarStyle = on ? .lightContent : .default
		}
		
		if (animated) {
			UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: moveBar, completion: {(bool) in changeStatusBar()
			})
		} else {
			moveBar()
			changeStatusBar()
		}
	}
	
	// MARK: XIB Setup
	private func xibSetup() {
		self.view = loadViewFromNib()
		self.view.frame = self.bounds
		self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(view)
	}
	
	private func loadViewFromNib() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: self.nibName, bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	
}
