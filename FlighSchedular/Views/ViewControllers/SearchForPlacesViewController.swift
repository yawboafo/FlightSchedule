//
//  SearchForPlacesViewController.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
class SearchForPlacesViewController: UIViewController {
	
	var subview : SearchPlaceSubView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		 self.view.backgroundColor = .white
		 self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeView)), animated: true)

	}
	
	@objc func closeView(){
		self.dismiss(animated:true)
	}
	
  override func viewDidLayoutSubviews() {
		view.addSubview(subview)
	   subview.constrainToSuperView(on: view,
											  top: 20,
											  bottom: -20)
		
	}

	
}
