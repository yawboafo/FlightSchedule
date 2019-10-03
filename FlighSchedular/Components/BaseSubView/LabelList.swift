//
//  LabelList.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 03/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit


class LabelList: UIView,BaseSubViewProtocol {
	func setUpSubViews() {
		
		stack.addArrangedSubview(titleLabel)
		stack.addArrangedSubview(subLabel)
		stack.addArrangedSubview(descriptionLabel)
		stack.addArrangedSubview(subDescriptionLabel)
    	addSubview(stack)
		constrainSubViews()
	}
	
	func bindModelToView() {
	}
	
	func constrainSubViews() {
		translatesAutoresizingMaskIntoConstraints = false
		stack.constrainToSuperView(on: self)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpSubViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	lazy var titleLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = "Title"
		view.numberOfLines = 0
		view.font = .systemFont(ofSize: 17, weight: .thin)
		return view
	}()
	
	lazy var subLabel: UILabel = {
		let view = UILabel()
		view.text = "Subtitle"
		view.numberOfLines = 0
		view.translatesAutoresizingMaskIntoConstraints = false
		view.font = .systemFont(ofSize: 14, weight: .regular)

		return view
	}()
	
	lazy var descriptionLabel: UILabel = {
		let view = UILabel()
		view.text = "Detail"
		view.numberOfLines = 0
		view.translatesAutoresizingMaskIntoConstraints = false
		view.font = .systemFont(ofSize: 14, weight: .bold)

		return view
	}()
	
	lazy var subDescriptionLabel: UILabel = {
		let view = UILabel()
		view.text = "Detail"
		view.numberOfLines = 0
		view.font = .systemFont(ofSize: 14, weight: .medium)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var stack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = 2
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
}
