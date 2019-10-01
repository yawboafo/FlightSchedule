//
//  SearchPlaceSubView.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import FloatingUIViews
import RxCocoa
import RxSwift
import MapKit

class SearchPlaceSubView: UIView {
	
	lazy var floatingSearchBox: FloatingSearchBox = {
		let searchBox = FloatingSearchBox()
	    	 searchBox.translatesAutoresizingMaskIntoConstraints = false
			return searchBox
	 }()
	
	lazy var searchButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Search", for: .normal)
		button.setTitleColor(.orange, for: .normal)
		button.setTitleColor(.red, for: .highlighted)
		button.layer.cornerRadius = 10
		button.layer.borderColor = UIColor.orange.cgColor
		button.layer.borderWidth = 1
		button.addTarget(self, action: #selector(searchForAirport), for: .touchUpInside)
		return button
	}()
	
	lazy var searchResultsTableView: UITableView = {
		let tableview = UITableView(frame: .zero)
		tableview.separatorStyle = .none
		tableview.translatesAutoresizingMaskIntoConstraints = false
		tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableview.keyboardDismissMode = .onDrag
		return tableview
	}()
	
	var viewModel : FlightSchedularViewModelImp!
   init(frame: CGRect = .zero,viewModel: FlightSchedularViewModelImp) {
		super.init(frame:frame)
		LayoutSubviews()
		self.viewModel = viewModel
	//	bindViewsToModel()
	}
	override init(frame: CGRect) {
		super.init(frame:frame)
		LayoutSubviews()
		//bindViewsToModel()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		bindViewsToModel()
	}
   func LayoutSubviews() {
	 translatesAutoresizingMaskIntoConstraints = false
	 addSubview(floatingSearchBox)
	 addSubview(searchButton)
	 addSubview(searchResultsTableView)
	 floatingSearchBox.pintoTop(superview: topAnchor)
	 floatingSearchBox.pintoLeft(superview: self,space: 20)
	 floatingSearchBox.pintoRight(superview: self,space: -20)
	 
	 searchButton.pintoBottom(superview: bottomAnchor)
	 searchButton.pintoLeft(superview: self,space: 40)
	 searchButton.pintoRight(superview: self,space: -40)
	 searchButton.setHeight(45)
	 
	 searchResultsTableView.pintoTop(superview: floatingSearchBox.bottomAnchor,space: 5)
	 searchResultsTableView.pintoLeft(superview: self)
	 searchResultsTableView.pintoRight(superview: self)
	 searchResultsTableView.pintoBottom(superview: searchButton.topAnchor,space: -5)
  }
	func bindViewsToModel(){
		
		guard let model = viewModel else { return  }
		guard let disposeBag = model.disposeBag else { return  }
		guard let binderString = (model.searchCompleter?.rx.queryFragment) else { return  }
		
		floatingSearchBox.startUIField
			.rx.text
			.orEmpty
			.bind(to: binderString)
			.disposed(by: disposeBag)
		
		
		floatingSearchBox.destinationUIField
			.rx.text
		   .orEmpty
		   .bind(to: binderString)
			.disposed(by: disposeBag)
		
		model.searchResults?.bind(to: searchResultsTableView
			.rx.items(cellIdentifier: "cell")) { row, searchResult, cell in
				print(searchResult.title,searchResult.subtitle)
				 cell.textLabel?.text = searchResult.title
				 cell.detailTextLabel?.text = searchResult.subtitle
			 }.disposed(by: disposeBag)
		
		searchResultsTableView
			.rx.modelSelected(MKLocalSearchCompletion.self)
			.subscribe(onNext: { [weak self] item in
				self?.floatingSearchBox.activeTextField.text = item.title
				self?.viewModel.getPlaceName(query: item)
			 }).disposed(by: disposeBag)
	}
	

	
	@objc func searchForAirport(){
		
		//pass this to places service
		//get code and map it for search
		
		print("start destination",floatingSearchBox.startUIField.text ?? "")
		print("end destination",floatingSearchBox.destinationUIField.text ?? "")
		
		viewModel.getFlightSchedules(from: floatingSearchBox.startUIField.text ?? "",
											  to: floatingSearchBox.destinationUIField.text ?? "")
	}

}
