//
//  FloatingSearchBar.swift
//  FloatingUIViews
//
//  Created by Engineer 144 on 30/09/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit



public protocol FloatingSearchBarDelegate{
			func barClicked()
	 }
	
  open class FloatingNavButton: UIView {
		 var delegate : FloatingSearchBarDelegate!
		 
		public init(frame: CGRect = .zero,delegate: FloatingSearchBarDelegate) {
			 super.init(frame: frame)
			 self.delegate = delegate
			 setupViews()

		 }
		 override init(frame: CGRect) {
			 super.init(frame: frame)
			 setupViews()

		 }
	required public init?(coder aDecoder: NSCoder) {
			 fatalError("init(coder:) has not been implemented")
		 }
	
		 func setupViews(){
			 backgroundColor = .white
			 self.setHeight(40)
			 self.setWith(40)
			 translatesAutoresizingMaskIntoConstraints = false
			 addShadow()
			 
			 
			 addSubview(menuButton)
			 menuButton.centerHorizontalToView(self)
			 menuButton.centerVerticalToView(self)

			 menuButton.setHeight(40)
			 menuButton.setWith(40)
			 
			 
		 }

		 @objc func respondToClick(){
			 guard let _delegate = delegate else { return  }
			 _delegate.barClicked()
		 }

		public lazy var menuButton: UIButton = {
			 let button = UIButton()
			 button.translatesAutoresizingMaskIntoConstraints = false
			button.addTarget(self, action: #selector(respondToClick), for: .touchUpInside)
			 return button
		 }()
		
		 
		 
	 }


