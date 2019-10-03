//
//  BaseSubView.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 02/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
protocol BaseSubViewProtocol :class {
	func setUpSubViews()
	func bindModelToView()
	func constrainSubViews()
}
