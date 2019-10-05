//
//  JourneyMapViewController.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import MapKit
//import FloatingUIViews
import  RxCocoa
import RxSwift

class JourneyMapViewController: UIViewController {

	var viewModel : FlightSchedularViewModel!
	
	override func viewDidLoad() {
		  super.viewDidLoad()
		  self.view.backgroundColor = .white
		  mapView.delegate = self
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

		  mapView.showAnnotations(viewModel.mkAnnotations(), animated: true)
		  let polyline = viewModel.getpolyLine()
		
		   self.mapView.setVisibleMapRect(polyline.boundingMapRect,
												    edgePadding: UIEdgeInsets(top: 40.0, left: 40.0, bottom: 40.0, right: 40.0),
												    animated: false)
		   mapView.addOverlay(viewModel.getpolyLine())
		
		
	}
	
		lazy var mapView: MKMapView = {
			let map = MKMapView()
			map.translatesAutoresizingMaskIntoConstraints = false
			map.mapType = MKMapType.standard
			map.isZoomEnabled = true
			map.isScrollEnabled = true
			map.showsCompass = true
			return map
		}()
		
		lazy var navBack: FloatingSearchBar = {
			let searchBar = FloatingSearchBar(delegate: self)
			searchBar.menuButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
			searchBar.translatesAutoresizingMaskIntoConstraints = false
			return searchBar
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



