//
//  FlightScheduleDetailSubView.swift
//  FlighSchedular
//
//  Created by Engineer 144 on 02/10/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FlightScheduleDetailSubView: UIView,BaseSubViewProtocol {


	var viewModel : FlightSchedularViewModelImp!
	var flightElement :  BehaviorRelay<[FlightElement]>!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpSubViews()
	}
	
	init(frame: CGRect = .zero,model: FlightSchedularViewModelImp) {
		super.init(frame: frame)
		viewModel = model
		setUpSubViews()
		bindModelToView()
	}
	
	init(frame: CGRect = .zero,data: BehaviorRelay<[FlightElement]>,model: FlightSchedularViewModelImp) {
		super.init(frame: frame)
			viewModel = model
			flightElement = data
			setUpSubViews()
			bindModelToView()
  }
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	lazy var flightsDetailTBV: ContentSizedTableView = {
		let tableview = ContentSizedTableView()
		tableview.translatesAutoresizingMaskIntoConstraints = false
		tableview.register(FlightDetailTableViewCell.self, forCellReuseIdentifier: "Cell")
		tableview.backgroundColor = .white
		tableview.separatorStyle = .none
		return tableview
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Transit Break Down"
		label.font = .systemFont(ofSize: 17, weight: .regular)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var contenDetailView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var detailTopView: LabelList = {
		let view = LabelList()
		view.subLabel.font = .systemFont(ofSize: 16, weight: .regular)
		view.descriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	func bindModelToView() {
		titleLabel.text = "Transit Break Down"
		
		
		flightElement.bind(to: flightsDetailTBV.rx.items(cellIdentifier: "Cell")) { row, model, cell in
		  let _cell = cell as! FlightDetailTableViewCell
			_cell.configure(flight: model, model: self.viewModel)
		}.disposed(by: viewModel.disposeBag!)
		
		
		flightsDetailTBV.rx.modelSelected(FlightElement.self)
			.subscribe(onNext: { [weak self] model in
				let flightModel = self?.viewModel.getFlightModule(element: model)
				guard let _model = flightModel else {return }
				self?.bindModelToView(model: _model)
			}).disposed(by: viewModel.disposeBag!)
		
		
		if flightElement.value.count > 0{
				 flightsDetailTBV.selectRow(at: IndexPath(row: 0, section: 0),
													 animated: true,
													 scrollPosition: UITableView.ScrollPosition.top)
			guard let flightModel = viewModel.getFlightModule(at: IndexPath(row: 0, section: 0)) else { return }
				 bindModelToView(model: flightModel)
		
			}
	
	}
	func bindModelToView(model: FlightModel){
		
		detailTopView.titleLabel.attributedText = NSMutableAttributedString()
		    .generic("Airline Detail : ",front: .systemFont(ofSize: 16, weight: .regular))
		    .generic("\(model.airplane)\n", front: .systemFont(ofSize: 16, weight: .thin))
			
  
		detailTopView.subLabel.attributedText =  NSMutableAttributedString()
			  .generic("Flight number : ",front: .systemFont(ofSize: 16, weight: .regular))
			  .generic("\(model.flightNumber)\n", front: .systemFont(ofSize: 16, weight: .thin))
			
			
		detailTopView.descriptionLabel.attributedText = NSMutableAttributedString()
		      .generic("Departure Airport: \n",front: .systemFont(ofSize: 16, weight: .regular))
		      .generic("\(model.departAirport)\n", front: .systemFont(ofSize: 16, weight: .thin))
		      .generic("Time : ", front: .systemFont(ofSize: 16, weight: .regular),color: .black)
				.generic("\(model.arrivalTime.smallDateTime)\n", front: .systemFont(ofSize: 16, weight: .thin),color: .black)
			
		
		detailTopView.subDescriptionLabel.attributedText = NSMutableAttributedString()
		     .generic("Arrival Airport: \n",front: .systemFont(ofSize: 16, weight: .regular))
		     .generic("\(model.arrivalAirport)\n", front: .systemFont(ofSize: 16, weight: .thin))
			  .generic("Time : ", front: .systemFont(ofSize: 16, weight: .regular),color: .black)
		     .generic("\(model.departTime.smallDateTime)\n", front: .systemFont(ofSize: 16, weight: .thin),color: .black)

	}
	func constrainSubViews() {
		translatesAutoresizingMaskIntoConstraints = false

		titleLabel.pintoLeft(superview: self)
		titleLabel.pintoRight(superview: self)
		titleLabel.pintoTop(superview: self)

		flightsDetailTBV.pintoTop(superview: titleLabel.bottomAnchor)
		flightsDetailTBV.pintoLeft(superview: self,space: 10)
		flightsDetailTBV.pintoRight(superview: self,space: -10)
		
		contenDetailView.pintoTop(superview: flightsDetailTBV.bottomAnchor,space: 10)
		contenDetailView.pintoLeft(superview: self)
		contenDetailView.pintoRight(superview: self)
		contenDetailView.pintoBottom(superview: self)
		
		detailTopView.pintoTop(superview: contenDetailView,space: 10)
		detailTopView.pintoLeft(superview: contenDetailView,space: 10)
		detailTopView.pintoRight(superview: contenDetailView,space: -10)
	
		
	}
	func setUpSubViews(){
		addSubview(titleLabel)
		addSubview(flightsDetailTBV)
		contenDetailView.addSubview(detailTopView)
		addSubview(contenDetailView)
		contenDetailView.addTopBorder(color: .lightGray, width: contenDetailView.frame.width)
		constrainSubViews()
	}
	
	
}

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
