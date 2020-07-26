//
//  RestaurantView.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation
import PureLayout

class RestaurantView: UIView {
    
    let containerView = UIView(forAutoLayout: ())
    let tableView = UITableView(forAutoLayout: ())
    let button = CustomButton()
    
    required init() {
        super.init(frame: .zero)
        
        containerView.addSubview(tableView)
        containerView.addSubview(button)
        
        addSubview(containerView)
        
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 100
    }
    
    private func setConstraints() {
        
    }
}
