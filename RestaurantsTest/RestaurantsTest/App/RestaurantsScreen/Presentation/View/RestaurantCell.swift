//
//  RestaurantCell.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 26/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit
import PureLayout

class RestaurantCell: UITableViewCell {
    
    let containerView = UIView(forAutoLayout: ())
    let iconImage = UIImageView(forAutoLayout: ())
    let nameLabel = UILabel(forAutoLayout: ())
    let timeLabel = UILabel(forAutoLayout: ())
    let scoreLabel = UILabel(forAutoLayout: ())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setCell()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell() {
        containerView.addSubview(iconImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(scoreLabel)
        
        addSubview(containerView)
        
        containerView.backgroundColor = .customBackgroundColor
        
        iconImage.clipsToBounds = true
        iconImage.layer.cornerRadius = 8
        
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: Constants.mainFont, size: 18)
        
        timeLabel.textColor = .black
        timeLabel.numberOfLines = 0
        timeLabel.font = UIFont(name: Constants.mainFont, size: 14)
        
        scoreLabel.textColor = .customSuccessColor
        scoreLabel.numberOfLines = 0
        scoreLabel.font = UIFont(name: Constants.mainFont, size: 14)
    }
    
    func setConstraints() {
        iconImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        iconImage.autoSetDimensions(to: CGSize(width: 70, height: 70))
        iconImage.autoPinEdge(.top, to: .top, of: containerView, withOffset: 15)
        iconImage.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -15)
        iconImage.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 30)
        
        nameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        nameLabel.autoPinEdge(.top, to: .top, of: containerView, withOffset: 20)
        nameLabel.autoPinEdge(.leading, to: .trailing, of: iconImage, withOffset: 30)
        
        timeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        timeLabel.autoPinEdge(.top, to: .top, of: nameLabel, withOffset: 22)
        timeLabel.autoPinEdge(.leading, to: .trailing, of: iconImage, withOffset: 30)
        
        scoreLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        scoreLabel.autoPinEdge(.top, to: .top, of: timeLabel, withOffset: 22)
        scoreLabel.autoPinEdge(.leading, to: .trailing, of: iconImage, withOffset: 30)
    }
    
    func set(_ restaurant: RestaurantModel) {
        iconImage.image = UIImage(named: "icon")
        nameLabel.text = restaurant.name
        timeLabel.text = "Delivery Time: " + restaurant.deliveryTime
        scoreLabel.text = "Score: \(restaurant.generalScore)"
    }
}
