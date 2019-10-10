//
//  Extensions.swift
//  FloatingUIViews
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//


import UIKit
public extension UIView{
	
	func setWith(_ width: CGFloat){
		self.widthAnchor.constraint(equalToConstant: width).isActive = true
	}
	
	func setHeight(_ width: CGFloat){
		self.heightAnchor.constraint(equalToConstant: width).isActive = true
	}
	
	func centerVerticalToView(_ view : UIView){
		self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	func centerHorizontalToView(_ view : UIView){
		self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	
	func setTopAnchor(onview : UIView,topAnchor : CGFloat)  {
		self.topAnchor.constraint(equalTo: onview.topAnchor,constant: topAnchor).isActive = true
	}
	
	func pintoLeft(superview: UIView,space: CGFloat = 0.0){
		self.leadingAnchor.constraint(equalTo: superview.leadingAnchor,constant: space).isActive = true
	}
	
	func pintoLeft(superview: NSLayoutAnchor<NSLayoutXAxisAnchor>,space: CGFloat = 0.0){
		self.leadingAnchor.constraint(equalTo: superview,constant: space).isActive = true
	}
	
	func pintoRight(superview: UIView,space: CGFloat = 0.0){
		self.trailingAnchor.constraint(equalTo: superview.trailingAnchor,constant: space).isActive = true
	}
	
	func pintoRight(superview: NSLayoutAnchor<NSLayoutXAxisAnchor>,space: CGFloat = 0.0){
		self.leadingAnchor.constraint(equalTo: superview,constant: space).isActive = true
	}
	func pintoTop(superview: UIView,space: CGFloat = 0.0){
		self.topAnchor.constraint(equalTo: superview.topAnchor,constant: space).isActive = true
	}
	//
	func pintoTop(superview: NSLayoutYAxisAnchor,space: CGFloat = 0.0){
		self.topAnchor.constraint(equalTo: superview,constant: space).isActive = true
	}
	
	func pintoBottom(superview: NSLayoutYAxisAnchor,space: CGFloat = 0.0){
		self.bottomAnchor.constraint(equalTo: superview,constant: space).isActive = true
	}
	
	
	func pintoBottom(superview: UIView,space: CGFloat = 0.0){
		self.bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant: space).isActive = true
	}
	
	func constraintoTop(superview view : UIView,
											topSpace : CGFloat = 0,
											leadingSpace : CGFloat = 0,
											trailingSpace : CGFloat = 0){
		self.topAnchor.constraint(equalTo: view.topAnchor,constant: topSpace).isActive = true
		self.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leadingSpace).isActive = true
		self.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: trailingSpace).isActive = true
	}
	
	
	func constrainToSuperViewNoGuide(on view : UIView){
		//let guide = view.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		
	}
	func constrainToBelowView(below view : UIView){
		let guide = view.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
		self.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
	}
	
	func constrainToSuperView(on view : UIView,
														top: CGFloat = 0,
														leading:CGFloat = 0,
														trailing:CGFloat = 0,
														bottom: CGFloat = 0){
		
		let guide = view.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: leading).isActive = true
		self.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: trailing).isActive = true
		self.bottomAnchor.constraint(equalTo: guide.bottomAnchor,constant: bottom).isActive = true
		self.topAnchor.constraint(equalTo: guide.topAnchor,constant: top).isActive = true
		
	}
	
	func constrainTopOfSuperView(on view : UIView,
															 leadingConstant:CGFloat = 0,
															 trailingConstant : CGFloat = 0){
		let guide = view.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: leadingConstant).isActive = true
		self.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: trailingConstant).isActive = true
		self.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
		
	}
	
	func constrainBelowSuperViewsTopView(superview : UIView,
																			 below topview : UIView,
																			 spacing: CGFloat = 0){
		
		let guide = superview.safeAreaLayoutGuide
		self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
		self.topAnchor.constraint(equalTo: topview.bottomAnchor,constant: spacing).isActive = true
		
	}
	
	
	
	func constrainBelowView(below: UIView,
													topSpace:CGFloat = 0,
													bottomSpace:CGFloat = 0,
													leadingSpace:CGFloat = 0,
													tralingSpace:CGFloat = 0 ,withBottomAchor:Bool = false){
		
		
		self.topAnchor.constraint(equalTo: below.bottomAnchor,constant: topSpace).isActive = true
		self.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: leadingSpace).isActive = true
		self.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: tralingSpace).isActive = true
		if withBottomAchor {
			self.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: bottomSpace).isActive = true
		}
		
	}
	
	
	func addShadow(){
		self.layer.cornerRadius = 10
		self.layer.shadowColor = UIColor.lightGray.cgColor
		self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
		self.layer.shadowRadius = 3
		self.layer.shadowOpacity = 0.9
		self.layer.masksToBounds = false
		
	}
}
