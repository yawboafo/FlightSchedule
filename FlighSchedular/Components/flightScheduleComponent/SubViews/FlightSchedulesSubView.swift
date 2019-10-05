//
//  FlightSchedulesSubView.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 01/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class FlightSchedulesSubView: UIView,BaseSubViewProtocol {
	
	var viewModel : FlightSchedularViewModelImp!
	
	lazy var schedulesTableView: UITableView = {
		let tblView = UITableView()
		tblView.register(FlightScheduleTBVCell.self, forCellReuseIdentifier: "Cell")
		tblView.translatesAutoresizingMaskIntoConstraints = false
		tblView.backgroundColor = .white
		tblView.delegate = self
		tblView.dataSource = self
		return tblView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpSubViews()
		
	}
   init(frame: CGRect = .zero,model: FlightSchedularViewModelImp) {
	 super.init(frame: frame)
	 self.viewModel = model
	 setUpSubViews()
	 
  }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUpSubViews() {
		translatesAutoresizingMaskIntoConstraints = false
		addSubview(schedulesTableView)
		constrainSubViews()
		
	}
	func bindModelToView() {
		
	}
	func constrainSubViews() {
		schedulesTableView.constrainToSuperView(on: self)
	}
	override func didMoveToSuperview() {
		schedulesTableView.reloadData()
	}
}

extension FlightSchedulesSubView : UITableViewDelegate,UITableViewDataSource{
	//ofcouse i could have used RXSWIFT BINDING , but decided to go vanilla
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.flightSchedules.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FlightScheduleTBVCell
		cell.configure(viewModel.scheduleAtIndex(indexPath))
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		  viewModel.setActiveSchedule(schedule: viewModel.scheduleAtIndex(indexPath))
	}
}
