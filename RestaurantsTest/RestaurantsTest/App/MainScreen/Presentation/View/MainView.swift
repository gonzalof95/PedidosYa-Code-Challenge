//
//  MainView.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit
import PureLayout

class MainView: UIView {
    
    let scrollView = UIScrollView(forAutoLayout: ())
    let containerView = UIView(forAutoLayout: ())
    let imageView = UIImageView(forAutoLayout: ())
    let imageView2 = UIImageView(forAutoLayout: ())
    let imageView3 = UIImageView(forAutoLayout: ())
    let button = CustomButton()
    
    required init() {
        super.init(frame: .zero)
        self.backgroundColor = .customBackgroundColor
        
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(imageView2)
        containerView.addSubview(imageView3)
        containerView.addSubview(button)
        addSubview(scrollView)
        
        setupScrollableArea()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollableArea() {
        scrollView.autoPinEdgesToSuperviewEdges()
        containerView.autoPinEdgesToSuperviewEdges()
        
        containerView.autoMatch(.width, to: .width, of: self)
        containerView.autoMatch(.height, to: .height, of: self).priority = .defaultLow
        
        imageView.image = UIImage(named: "mai")
        imageView2.image = UIImage(named: "mai")
        imageView3.image = UIImage(named: "mai")
        
        button.setTitle("Search for Restaurants", for: .normal)
    }
    
    private func setupContraints() {
        imageView.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        imageView.autoPinEdge(.top, to: .top, of: containerView, withOffset: 27)
        imageView.autoSetDimensions(to: CGSize(width: 375, height: 300))
        
        imageView2.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        imageView2.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 47)
        imageView2.autoSetDimensions(to: CGSize(width: 375, height: 300))
        
        imageView3.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        imageView3.autoPinEdge(.top, to: .bottom, of: imageView2, withOffset: 47)
        imageView3.autoSetDimensions(to: CGSize(width: 375, height: 300))
        
        button.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        button.autoSetDimension(.height, toSize: 44)
        button.autoPinEdge(.top, to: .bottom, of: imageView3, withOffset: 12, relation: .greaterThanOrEqual)
        button.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -32)
        button.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 20)
        button.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -20)
    }
}
