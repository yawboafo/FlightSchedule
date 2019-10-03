//
//  FlightDetailTableViewCell.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 02/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class FlightDetailTableViewCell: UITableViewCell,BaseSubViewProtocol {
	
	
	func setUpSubViews() {
		addSubview(centerIcon)
		addSubview(arirvalDetailUIView)
		addSubview(departTureDetailUIView)
		constrainSubViews()
	}
	
	func bindModelToView() {
		
	}
	
	func constrainSubViews() {
		
		centerIcon.setHeight(25)
		centerIcon.setWith(25)
		centerIcon.centerVerticalToView(self)
		centerIcon.centerHorizontalToView(self)
		
		departTureDetailUIView.setWith(300)
		arirvalDetailUIView.setWith(300)
		
		print(UIScreen.main.bounds.width)
		departTureDetailUIView.pintoTop(superview: self,space: 10)
		departTureDetailUIView.pintoLeft(superview: self,space: 5)
	
		departTureDetailUIView.centerHorizontalToView(self)
		
		arirvalDetailUIView.pintoRight(superview: self,space: -5)
		
		
		arirvalDetailUIView.centerHorizontalToView(self)
		arirvalDetailUIView.pintoBottom(superview: self,space: -10)
		
		centerIcon.pintoRight(superview: departTureDetailUIView.trailingAnchor,space: -2)
		centerIcon.pintoLeft(superview: arirvalDetailUIView.leadingAnchor,space: 2)
		

	}
	
	func configure(flight : FlightElement,model: FlightSchedularViewModelImp){
		
		guard let flight = model.getFlightModule(element: flight) else { return }
		
		let arrivalView = arirvalDetailUIView
		arrivalView.titleLabel.text = flight.aAirCode
		arrivalView.subLabel.text =   flight.arrivalTime
		arrivalView.descriptionLabel.text =  flight.arrivalTerminal
		arrivalView.subDescriptionLabel.isHidden = true
		
		let departureView = departTureDetailUIView
		departureView.titleLabel.text = flight.dAirCode
		departureView.subLabel.text =   flight.departTime
      departureView.descriptionLabel.text = flight.departTerminal
		departureView.subDescriptionLabel.isHidden = true
		

		
	}
	

	required init?(coder: NSCoder) {
		fatalError("required")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpSubViews()
	}
	
	lazy var centerIcon: UIImageView = {
		let view = UIImageView()
		view.image = #imageLiteral(resourceName: "airline")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var arirvalDetailUIView: LabelList = {
		let view = LabelList()
		view.titleLabel.textAlignment = .right
		view.subLabel.textAlignment = .right
		view.descriptionLabel.textAlignment = .right
		view.subDescriptionLabel.textAlignment = .right

		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var departTureDetailUIView: LabelList = {
		let view = LabelList()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

}


