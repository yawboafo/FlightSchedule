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

class JourneyMapViewCoordinator: Coordinator{
	var model : FlightSchedularViewModelImp!

	var searchplacesCoordinator : SearchForPlacesCoordinator!
	weak var rootViewController: UIViewController!

	
	func start() -> UIViewController {
		let mapViewController = JourneyMapViewController()
		model = FlightSchedularViewModelImp()
		model.coordinatorDelegate = self
		mapViewController.viewModel = model
		self.rootViewController = mapViewController
		return mapViewController
	}

}


extension JourneyMapViewCoordinator: JourneyMapViewCoordinatorDelegate{
	func presentView() {
		searchplacesCoordinator = SearchForPlacesCoordinator(viewmodel: self.model)
		//searchplacesCoordinator.init
	   	let searchView = searchplacesCoordinator.start()
		   let navController = UINavigationController(rootViewController: searchView)
		   navController.modalPresentationStyle = .overFullScreen
	     	rootViewController.present(navController, animated: true, completion: nil)
	}
	
	
}
