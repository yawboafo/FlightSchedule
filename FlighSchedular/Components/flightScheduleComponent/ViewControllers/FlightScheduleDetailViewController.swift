//
//  ScheduleDetailViewController.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 02/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class FlightScheduleDetailViewController: UIViewController {

	var subView : FlightScheduleDetailSubView!
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(closeView))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show on map", style: .done, target: self, action: #selector(showMap))

    }
	@objc func closeView(){
		self.navigationController?.popViewController(animated: true)
	}
	@objc func showMap(){
		self.subView.viewModel.openMapView()
	}
	 override func viewDidLayoutSubviews() {
		 view.addSubview(subView)
		 subView.constrainToSuperView(on: view,
												top: 10,
												bottom: -10)
		 
	 }

	
}
