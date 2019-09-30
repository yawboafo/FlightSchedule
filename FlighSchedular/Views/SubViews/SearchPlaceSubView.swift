//
//  SearchPlaceSubView.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import FloatingUIViews

class SearchPlaceSubView: UIView {
	override init(frame: CGRect) {
		super.init(frame:frame)
		LayoutSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
		//button.addTarget(self, action: #selector(searchForAirport), for: .touchUpInside)
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
	

}
