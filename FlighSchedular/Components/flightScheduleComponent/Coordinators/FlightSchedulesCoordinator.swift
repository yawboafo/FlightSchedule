//
//  FlightSchedulesCoordinator.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 01/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
protocol FlightSchedulesCoordinatorProtocol {
	func presentMapView()
	func showDetail(model:FlightSchedularViewModelImp)
	func showDetail(model:FlightSchedularViewModelImp,data:BehaviorRelay<[FlightElement]>)
}

class FlightSchedulesCoordinator: BaseCoordinator {
	
	var model : FlightSchedularViewModelImp!
	weak var rootViewController: UIViewController!
	var journeyMapCoordinator : JourneyMapViewCoordinator!


	init(viewmodel: FlightSchedularViewModelImp) {
		self.model  = viewmodel
		self.model.scheduleCoordinatorDelegate = self
	}
	func start() -> UIViewController {
		let view = FlightSchedulesViewController()
		let subview = FlightSchedulesSubView(model: model)
		view.subview = subview
		rootViewController = view
		return view
	}
	
	
	func detailView(model: FlightSchedularViewModelImp,_data:BehaviorRelay<[FlightElement]>)->UIViewController{
		let view = FlightScheduleDetailViewController()
	//	rootViewController = view
		let subview = FlightScheduleDetailSubView(data: _data, model: model)
		view.subView = subview
		return view
	}
	
	func detailMapView(){
		let view = JourneyMapViewCoordinator(model: self.model).start()
		
		rootViewController.show(view, sender: self)  //navigationController?.present(view, animated: true, completion: nil)
	}
}

extension FlightSchedulesCoordinator : FlightSchedulesCoordinatorProtocol,JourneyMapViewCoordinatorDelegate{
	func presentMapView() {
		detailMapView()
	}
	
	func presentView() {
		detailMapView()
	}
	
	func showDetail(model: FlightSchedularViewModelImp, data: BehaviorRelay<[FlightElement]>) {
			rootViewController?.show(detailView(model: model,_data: data), sender: self)
	}
	
	func showDetail(model:FlightSchedularViewModelImp) {
	
	}
}
