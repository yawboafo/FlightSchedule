//
//  DestinationCoordinator.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit


protocol JourneyMapViewCoordinatorDelegate: class{
	func presentView()
}

class JourneyMapViewCoordinator: BaseCoordinator{
	var model : FlightSchedularViewModelImp!

	var searchplacesCoordinator : SearchForPlacesCoordinator!
	weak var rootViewController: UIViewController!

	init(model:FlightSchedularViewModelImp) {
		self.model = model
	}
	
	func start() -> UIViewController {
		let mapViewController = JourneyMapViewController()
		//model = FlightSchedularViewModelImp()
		//model.coordinatorDelegate = self
		mapViewController.viewModel = self.model
		self.rootViewController = mapViewController
		//mapViewController.modalPresentationStyle = .overFullScreen
		return mapViewController
	}

}


extension JourneyMapViewCoordinator: JourneyMapViewCoordinatorDelegate{
	func presentView() {
		   searchplacesCoordinator = SearchForPlacesCoordinator(viewmodel: self.model)
	   	let searchView = searchplacesCoordinator.start()
		   let navController = UINavigationController(rootViewController: searchView)
		   navController.modalPresentationStyle = .overFullScreen
	     	rootViewController.present(navController, animated: true, completion: nil)
	}
	
	
}
