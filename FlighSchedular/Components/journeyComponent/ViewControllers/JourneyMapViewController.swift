//
//  JourneyMapViewController.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import MapKit
import FloatingUIViews
import  ObjectiveC
class JourneyMapViewController: UIViewController {

	var viewModel : FlightSchedularViewModel!
	var annootations : [MKAnnotation] = []
   var points: [CLLocationCoordinate2D] = []
	
	
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
		
		let annotations = getMapAnnotations()
		 annootations  = annotations.compactMap{ args in
			let arrayofAnnotation : [MKAnnotation]  = [args.departure,args.arrival]
			return arrayofAnnotation as? MKAnnotation
		}
		mapView.addAnnotations(annootations)
				 
				 mapView.delegate = self
				 
				 points = [CLLocationCoordinate2D]()
				 
				 for annotation in annotations {
					points.append(annotation.departure.coordinate)

					points.append(annotation.arrival.coordinate)
				 }
				 
		print("count : \(points.count)",points)
				 let polyline = MKPolyline(coordinates: &points, count: points.count)
				 self.mapView.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 40.0, left: 40.0, bottom: 40.0, right: 40.0), animated: false)
		      mapView.addOverlay(polyline)
		
		mapView.showAnnotations(mapView.annotations, animated: true)

	}
	
		 
		lazy var mapView: MKMapView = {
			let map = MKMapView()
			map.translatesAutoresizingMaskIntoConstraints = false
			map.mapType = MKMapType.standard
			map.isZoomEnabled = true
			map.isScrollEnabled = true
			map.delegate = self
			
			return map
		}()
		
		lazy var floatingSearchBar: FloatingSearchBar = {
			let searchBar = FloatingSearchBar(delegate: self)
			searchBar.menuButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
			searchBar.translatesAutoresizingMaskIntoConstraints = false
			return searchBar
		}()
		
		override func viewWillLayoutSubviews() {
		   view.addSubview(mapView)
			mapView.constrainToSuperView(on: view)
			mapView.addSubview(floatingSearchBar)
		   floatingSearchBar.pintoTop(superview: mapView.safeAreaLayoutGuide.topAnchor,space: 20)
			floatingSearchBar.pintoLeft(superview: mapView,space: 20)
			
		}
	
	  func getMapAnnotations() -> [(arrival:MKAnnotation,departure:MKAnnotation)] {
		var annotations : [(arrival:MKAnnotation,departure:MKAnnotation)] = []
		let schedules = viewModel.scheduleFlightElement
			 
		for item in schedules{
			let flightModule = viewModel.getFlightModule(element: item)
			guard let arriveAnotation = (flightModule?.arrivalIATA.getAnnotation) else { continue }
			arriveAnotation.title = flightModule?.arrivalAirport
			arriveAnotation.subtitle = flightModule?.arrivalTime
			
			guard let destinationAnotation = (flightModule?.departtureIATA.getAnnotation) else { continue }
			destinationAnotation.title = flightModule?.departAirport
			destinationAnotation.subtitle = flightModule?.departTime
			
			annotations.append((arrival:arriveAnotation,departure:destinationAnotation))
			
			
		}
		 return annotations
			
		}
		

}

extension JourneyMapViewController: FloatingSearchBarDelegate{
	func barClicked() {
		self.navigationController?.popViewController(animated: true)
		//viewModel?.openSearchAirportView()
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
	func mapView(_mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		  //This is the mapview delegate method that adjusts the annotation views.

		if annotation.isKind(of: MKUserLocation.self) {

				//We don't do anything with the user location, so ignore an annotation that has to do with the user location.
				return nil
		  }

		  let identifier = "customPin"
		  let trackAnnotation = MKAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)

		  trackAnnotation.canShowCallout = true

		  if annotation.title! == "Some specific title" { //Display a different image
				trackAnnotation.image = UIImage(named: "StartAnnotation")
				let offsetHeight = (trackAnnotation.image?.size.height)! / 2.0
				trackAnnotation.centerOffset = CGPoint(x: 0, y: -offsetHeight)
		  } else { //Display a standard image.
				trackAnnotation.image = UIImage(named: "StopAnnotation")
				let offsetHeight = (trackAnnotation.image?.size.height)! / 2.0
				trackAnnotation.centerOffset = CGPoint(x: 0, y: -offsetHeight)
		  }

		  return trackAnnotation
	 }
}



