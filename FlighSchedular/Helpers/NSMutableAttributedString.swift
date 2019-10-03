//
//  NSMutableAttributedString.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 03/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import Foundation
import UIKit
extension NSMutableAttributedString {
	
	
	
	@discardableResult func generic(_ text:String,front: UIFont,color:UIColor = .black) -> NSMutableAttributedString {
		var attrs = [NSAttributedString.Key: AnyObject]()
		attrs[NSAttributedString.Key.font] = front
		attrs[NSAttributedString.Key.foregroundColor] = color
		let smallString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
		self.append(smallString)
		return self
	}

}
