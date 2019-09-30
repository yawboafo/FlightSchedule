//
//  SearchForPlacesCoordinator.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
class SearchForPlacesCoordinator: Coordinator{
	
	var model : FlightSchedularViewModelImp!
	
	init(viewmodel: FlightSchedularViewModelImp) {
		
		self.model  = viewmodel
	}
	
	func start() -> UIViewController {
		let subView = SearchPlaceSubView(viewModel: self.model)
		let viewController = SearchForPlacesViewController()
		viewController.subview = subView
		return viewController
	}
}
