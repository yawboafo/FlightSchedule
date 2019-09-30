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
class JourneyMapViewController: UIViewController {

	var viewModel : FlightSchedularViewModel!
	
	 override func viewDidLoad() {
			super.viewDidLoad()
		 }
		 
		lazy var mapView: MKMapView = {
			let map = MKMapView()
			map.translatesAutoresizingMaskIntoConstraints = false
			map.mapType = MKMapType.standard
			map.isZoomEnabled = true
			map.isScrollEnabled = true
			return map
		}()
		
		lazy var floatingSearchBar: FloatingSearchBar = {
			let searchBar = FloatingSearchBar(delegate: self)
			searchBar.menuButton.setImage(#imageLiteral(resourceName: "marker"), for: .normal)
			searchBar.searhButton.setTitle("Search for a destination", for: .normal)
			searchBar.translatesAutoresizingMaskIntoConstraints = false
			return searchBar
		}()
		
		override func loadView() {
			view = mapView
		}
		override func viewWillLayoutSubviews() {
			 view.addSubview(floatingSearchBar)
			 floatingSearchBar.pintoTop(superview: view.safeAreaLayoutGuide.topAnchor,space: 20)
			 floatingSearchBar.pintoLeft(superview: view,space: 20)
			 floatingSearchBar.pintoRight(superview: view,space: -20)
		}

}

extension JourneyMapViewController: FloatingSearchBarDelegate{
	func barClicked() {
		viewModel?.searchforNearByAirports()
	}
	
	
}

