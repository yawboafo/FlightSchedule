//
//  FloatingSearchBox.swift
//  FloatingUIViews
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
open class FloatingSearchBox : UIView{
	public var activeTextField : UITextField!

	
	
	open override func didMoveToSuperview() {
		super.didMoveToSuperview()
		startUIField.delegate = self
		destinationUIField.delegate = self
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpViews()
	}
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func setUpViews(){
		self.backgroundColor =  .white //UIColor(red: 0.8588, green: 0.8588, blue: 0.8588, alpha: 1.0)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setHeight(100)
		addShadow()
		
		startStack.addArrangedSubview(blackdot)
		startStack.addArrangedSubview(startUIField)
		
		destinationStack.addArrangedSubview(reddot)
		destinationStack.addArrangedSubview(destinationUIField)
		
		
		container.addSubview(startStack)
		container.addSubview(destinationStack)
		
		startStack.pintoTop(superview: container,space: 10)
		startStack.pintoRight(superview: container,space: -2)
		startStack.pintoLeft(superview: container,space: 2)
		
		
		destinationStack.pintoTop(superview: startStack.bottomAnchor,space: 20)
		destinationStack.pintoBottom(superview: container,space: -10)
		destinationStack.pintoRight(superview: container,space: -2)
		destinationStack.pintoLeft(superview: container,space: 2)
		
		addSubview(container)
		container.centerHorizontalToView(self)
		container.centerVerticalToView(self)
		container.pintoRight(superview: self,space: -20)
		container.pintoLeft(superview: self,space: 20)
		
		
	}
	
	lazy var container: UIView = {
		let view  = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	 lazy var startStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = UIStackView.Distribution.fillProportionally
		stack.axis = .horizontal
		stack.spacing = 15
		return stack
	}()
	
	
	lazy var destinationStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = UIStackView.Distribution.fillProportionally
		stack.axis = .horizontal
		stack.spacing = 15
		return stack
	}()
	
	lazy var blackdot: UIView = {
		let view = UIView()
		view.backgroundColor = .black
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setHeight(15)
		view.setWith(15)
		view.layer.cornerRadius = 7.5
		return view
	}()
	
	lazy var reddot: UIView = {
		let view = UIView()
		view.backgroundColor = .red
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setHeight(15)
		view.setWith(15)
		view.layer.cornerRadius = 7.5
		return view
	}()
	
	public lazy var startUIField: UITextField = {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		
		field.placeholder = "Origin Airport"
		field.clearButtonMode = .whileEditing
		
		return field
	}()
	
	public lazy var destinationUIField: UITextField = {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		field.clearButtonMode = .whileEditing
		field.placeholder = "Destination Airport"
		//field.delegate = self

		return field
	}()
	
	
}


extension FloatingSearchBox: UITextFieldDelegate{
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		self.activeTextField = textField
	}
}
