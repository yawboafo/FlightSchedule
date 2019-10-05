//
//  JourneyMapViewController.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import MapKit
import  RxCocoa
import RxSwift

class JourneyMapViewController: UIViewController {

	var viewModel : FlightSchedularViewModel!
	
	override func viewDidLoad() {
		  super.viewDidLoad()
		  self.view.backgroundColor = .white
	 }
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.isHidden = true
	}
	
	override func viewDidAppear(_ animated: Bool) {
		buildMap()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.navigationBar.isHidden = false
	}
	

	func buildMap(){
		
		let polyline = viewModel.getpolyLine()
		mapView.setVisibleMapRect(polyline.boundingMapRect,
										  edgePadding: UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0),
										  animated: true)
		mapView.addOverlay(viewModel.getpolyLine())
		mapView.showAnnotations(viewModel.mkAnnotations(), animated: true)
		
	}
	
		lazy var mapView: MKMapView = {
			let map = MKMapView()
			map.translatesAutoresizingMaskIntoConstraints = false
			map.mapType = MKMapType.standard
			map.isZoomEnabled = true
			map.isScrollEnabled = true
			map.showsCompass = true
			map.delegate = self
			
		   map.register(LocationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
			return map
		}()
		
		lazy var navBack: FloatingNavButton = {
			let button = FloatingNavButton(delegate: self)
			button.menuButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
			button.translatesAutoresizingMaskIntoConstraints = false
			return button
		}()
		
	
		override func viewWillLayoutSubviews() {
		   view.addSubview(mapView)
			mapView.constrainToSuperView(on: view)
			mapView.addSubview(navBack)
		   navBack.pintoTop(superview: mapView.safeAreaLayoutGuide.topAnchor,space: 20)
			navBack.pintoLeft(superview: mapView,space: 20)
			
		}
	
}

extension JourneyMapViewController: FloatingSearchBarDelegate{
	func barClicked() {
		self.navigationController?.popViewController(animated: true)
	}
}

extension JourneyMapViewController:MKMapViewDelegate{
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		 let polylineRenderer = MKPolylineRenderer(overlay: overlay)
		 
		 if overlay is MKPolyline {
			  polylineRenderer.strokeColor = UIColor.orange
			  polylineRenderer.lineWidth = 5
		 }
		 return polylineRenderer
	}
	
}



