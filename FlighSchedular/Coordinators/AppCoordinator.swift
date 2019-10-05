//
//  AppCoordinator.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

final class AppCoordinator : BaseCoordinator{
    
    private var window : UIWindow?
    init(window : UIWindow) {
        self.window = window
		  model = FlightSchedularViewModelImp()
    }
	 var model : FlightSchedularViewModelImp!
    var journeyCoordinator : JourneyMapViewCoordinator!
	 var searchplacesCoordinator : SearchForPlacesCoordinator!

	func start() -> UIViewController {
		       
		        searchplacesCoordinator = SearchForPlacesCoordinator(viewmodel: self.model)
				  let searchView = searchplacesCoordinator.start()
				  let navController = UINavigationController(rootViewController: searchView)
		        self.window?.rootViewController = navController
		        self.window?.makeKeyAndVisible()
		        self.window?.tintColor = UIColor.orange
		        return navController
	}

}

