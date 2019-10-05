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

class SearchPlaceSubView: UIView,BaseSubViewProtocol {
	
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
	
	lazy var switcher: UISwitch = {
		let view = UISwitch()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.onTintColor = .orange
		view.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
		return view
	}()
	
	lazy var directFlightLabel: UILabel = {
		let view = UILabel()
		view.text = "Direct Flights"
		view.textColor = .lightGray
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var stack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
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
		setUpSubViews()
		self.viewModel = viewModel
		bindModelToView()
	}
	override init(frame: CGRect) {
		super.init(frame:frame)
		setUpSubViews()
		bindModelToView()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
   func setUpSubViews() {
	     translatesAutoresizingMaskIntoConstraints = false
	     addSubview(floatingSearchBox)
	     addSubview(switcher)
	     addSubview(searchButton)
	     addSubview(searchResultsTableView)
		
	  stack.addArrangedSubview(directFlightLabel)
     stack.addArrangedSubview(switcher)
     addSubview(stack)
	  constrainSubViews()
	
  }
	func constrainSubViews(){
		   floatingSearchBox.pintoTop(superview: topAnchor)
			floatingSearchBox.pintoLeft(superview: self,space: 20)
			floatingSearchBox.pintoRight(superview: self,space: -20)
			
			searchButton.pintoBottom(superview: bottomAnchor)
			searchButton.pintoLeft(superview: self,space: 40)
			searchButton.pintoRight(superview: self,space: -40)
			searchButton.setHeight(45)
			  
			stack.pintoTop(superview: floatingSearchBox.bottomAnchor,space: 10)
			stack.pintoLeft(superview: self,space: 25)
			stack.pintoRight(superview: self,space: -25)
			
			searchResultsTableView.pintoTop(superview: stack.bottomAnchor,space: 5)
			searchResultsTableView.pintoLeft(superview: self)
			searchResultsTableView.pintoRight(superview: self)
			searchResultsTableView.pintoBottom(superview: searchButton.topAnchor,space: -5)
	}
	
	func bindModelToView(){
		
		guard let model = viewModel else { return  }
		guard let disposeBag = model.disposeBag else { return  }
		guard let binderString = (model.searchCompleter) else { return  }
		
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
			//	print(searchResult.title,searchResult.subtitle)
				cell.textLabel?.text = searchResult.name
				cell.detailTextLabel?.text = searchResult.iata
			 }.disposed(by: disposeBag)
		
		
		searchResultsTableView
			.rx.modelSelected(IATA.self)
			.subscribe(onNext: { [weak self] item in
				self?.floatingSearchBox.activeTextField.text = item.name
			 }).disposed(by: disposeBag)
		
	}
	
	@objc func switchChanged(mySwitch: UISwitch) {
		 let value = mySwitch.isOn
		directFlightLabel.textColor = (value == true ? .black : .lightGray)
	}
	
	@objc func searchForAirport(){
	
		showDatePicker(dateHandler: { [weak self](date) in
			self?.viewModel.getFlightSchedules(from: self?.floatingSearchBox.startUIField.text ?? "",
			                                   to: self?.floatingSearchBox.destinationUIField.text ?? "",
														  dateFrom: date,directFlight: self?.switcher.isOn ?? false)
		       }) {
			
		   }
		
		}
		
		
	}


