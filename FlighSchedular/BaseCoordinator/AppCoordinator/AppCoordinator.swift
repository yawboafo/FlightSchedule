//
//  AppCoordinator.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

final class AppCoordinator : Coordinator{
    
    private var window : UIWindow?
    init(window : UIWindow) {
        self.window = window
    }
    var journeyCoordinator : JourneyMapViewCoordinator!

	 func start()-> UIViewController{
        journeyCoordinator = JourneyMapViewCoordinator()
        let mainVC = journeyCoordinator.start()
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return mainVC
    }
}

