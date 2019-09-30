//
//  DestinationCoordinator.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit


protocol JourneyMapViewCoordinatorDelegate: class{
	func beginSearch()
}

class JourneyMapViewCoordinator: Coordinator{
	
	var searchplacesCoordinator : SearchForPlacesCoordinator!
	weak var rootViewController: UIViewController!

	
	func start() -> UIViewController {
		let mapViewController = JourneyMapViewController()
		let viewModel = FlightSchedularViewModelImp()
		viewModel.coordinatorDelegate = self
		mapViewController.viewModel = viewModel
		self.rootViewController = mapViewController
		return mapViewController
	}

}


extension JourneyMapViewCoordinator: JourneyMapViewCoordinatorDelegate{
	func beginSearch() {
		  searchplacesCoordinator = SearchForPlacesCoordinator()
	   	let searchView = searchplacesCoordinator.start()
		   let navController = UINavigationController(rootViewController: searchView)
		   navController.modalPresentationStyle = .overFullScreen
	     	rootViewController.present(navController, animated: true, completion: nil)
	}
	
	
}
