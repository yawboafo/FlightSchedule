//
//  SearchForPlacesCoordinator.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
protocol SearchForPlacesCoordinatorDelegate:class {
	func showError(error: APIError)
	func showSchedules(schedules: ScheduleResource)
	func showSipnner()
	
}
class SearchForPlacesCoordinator: BaseCoordinator{
	
	var model : FlightSchedularViewModelImp!
	var flightschedulesCoordinator : FlightSchedulesCoordinator!
	weak var progressDialog: UIViewController!
	weak var rootViewController: UIViewController!

	init(viewmodel: FlightSchedularViewModelImp) {
		self.model  = viewmodel
		self.model.placesCoordinatorDelegate = self
	}
	
	func start() -> UIViewController {
		let subView = SearchPlaceSubView(viewModel: self.model)
		let viewController = PlacesViewController()
		rootViewController = viewController
		viewController.subview = subView
		return viewController
	}
   func showPleaseWaitDailog(title: String,message: String )-> UIAlertController {
	     let  PleaseWaitDailog = UIAlertController(title: title, message: message, preferredStyle: .alert)
	     let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 2, width: 50, height: 50))
	         loadingIndicator.hidesWhenStopped = true
	         loadingIndicator.style = .gray
	         loadingIndicator.startAnimating();
	        PleaseWaitDailog.view.addSubview(loadingIndicator)
	 return PleaseWaitDailog
  }
	func presentflightschedulesView(){
		flightschedulesCoordinator = FlightSchedulesCoordinator(viewmodel: self.model)
		let flightsView = flightschedulesCoordinator.start()
		let navController = UINavigationController(rootViewController: flightsView)
		navController.modalPresentationStyle = .overFullScreen
		rootViewController.navigationController?.show(flightsView, sender: self)
		//rootViewController.present(navController, animated: true)
	}
}


extension SearchForPlacesCoordinator :SearchForPlacesCoordinatorDelegate{
	
	func showSipnner() {
		progressDialog = showPleaseWaitDailog(title: "Hold on", message: "Getting flight schedules")
		rootViewController.present(progressDialog, animated: true)
	}
	
	func showError(error: APIError) {
		progressDialog.dismiss(animated: true,completion: {
			self.rootViewController.showWarningDialog(with: "Failed",
			                                       and: error.readable)
		})
		
	}
	
	func showSchedules(schedules: ScheduleResource) {
		progressDialog.dismiss(animated: true, completion: {
			self.presentflightschedulesView()
		})
		   
	}
	
	
}
