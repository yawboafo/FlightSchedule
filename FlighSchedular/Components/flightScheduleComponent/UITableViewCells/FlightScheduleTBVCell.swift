//
//  FlightScheduleTBVCell.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 01/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
class FlightScheduleTBVCell: UITableViewCell {
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpSubViews()
		constrainSubViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("required")
	}
	
	func setUpSubViews(){
		accessoryType = .disclosureIndicator
		journeyStack.addArrangedSubview(journeyLabel)
		journeyStack.addArrangedSubview(journeyValue)
		
		timeStack.addArrangedSubview(timeLabel)
		timeStack.addArrangedSubview(timeValue)
		
		addSubview(journeyStack)
		addSubview(timeStack)
		

	}
	
	func constrainSubViews(){
		timeStack.pintoTop(superview: self,space:5)
		timeStack.pintoLeft(superview: self,space: 10)
		
		journeyStack.pintoLeft(superview: self,space: 10)
		journeyStack.pintoTop(superview: timeStack.bottomAnchor,space:5)
		journeyStack.pintoBottom(superview: self,space:-5)
		
		
	}
	
	func configure(_ schedule : Schedule){
		let _schedule = ScheduleModel(schedule: schedule)
		journeyValue.text = _schedule.totalTransits
		timeValue.text = _schedule.readableDuration
	}
	
	lazy var timeLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.text = "Journey Duration"
		label.textColor = .lightGray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var timeValue: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var timeStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		return stack
	}()
	
	
	lazy var journeyLabel: UILabel = {
		let label = UILabel()
		label.text = "Total Transits : "
		label.textColor = .lightGray
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var journeyValue: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var journeyStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	
}
