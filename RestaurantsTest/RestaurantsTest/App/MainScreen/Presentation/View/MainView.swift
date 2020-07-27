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
    let label = UILabel(forAutoLayout: ())
    let label2 = UILabel(forAutoLayout: ())
    let button = CustomButton()
    let button2 = CustomButton()
    let button3 = CustomButton()
    
    required init() {
        super.init(frame: .zero)
        self.backgroundColor = .customBackgroundColor
        
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(imageView2)
        containerView.addSubview(imageView3)
        containerView.addSubview(label)
        containerView.addSubview(label2)
        containerView.addSubview(button)
        containerView.addSubview(button2)
        containerView.addSubview(button3)
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
        
        imageView.image = UIImage(named: "banner1")
        imageView2.image = UIImage(named: "image1")
        imageView2.clipsToBounds = true
        imageView2.layer.cornerRadius = 8
        imageView3.image = UIImage(named: "image2")
        imageView3.clipsToBounds = true
        imageView3.layer.cornerRadius = 8
        
        label.textColor = .black
        label.font = UIFont(name: Constants.mainFont, size: 20)
        label.text = "Suggestions"
        
        label2.textColor = .black
        label2.font = UIFont(name: Constants.mainFont, size: 18)
        label2.text = "Online pay"
        
        button.setTitle("Show in Table", for: .normal)
        button2.setTitle("Show in Map", for: .normal)
        button3.setTitle("Use custom location", for: .normal)
    }
    
    private func setupContraints() {
        imageView.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        imageView.autoPinEdge(.top, to: .top, of: containerView, withOffset: 27)
        imageView.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 25)
        imageView.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -25)
        imageView.autoSetDimension(.height, toSize: 110)
        
        label.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        label.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 30)
        label.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 25)
        
        imageView2.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        imageView2.autoPinEdge(.top, to: .bottom, of: label, withOffset: 12)
        imageView2.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 25)
        imageView2.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -25)
        imageView2.autoSetDimension(.height, toSize: 180)

        label2.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        label2.autoPinEdge(.top, to: .bottom, of: imageView2, withOffset: 30)
        label2.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 25)
        
        imageView3.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        imageView3.autoPinEdge(.top, to: .bottom, of: label2, withOffset: 12)
        imageView3.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 25)
        imageView3.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -25)
        imageView3.autoSetDimension(.height, toSize: 180)
        
        button.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        button.autoSetDimension(.height, toSize: 44)
        button.autoPinEdge(.top, to: .bottom, of: imageView3, withOffset: 24, relation: .greaterThanOrEqual)
        button.autoPinEdge(.bottom, to: .top, of: button2, withOffset: -12)
        button.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 20)
        button.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -20)
        
        button2.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        button2.autoSetDimension(.height, toSize: 44)
        button2.autoPinEdge(.bottom, to: .top, of: button3, withOffset: -12)
        button2.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 20)
        button2.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -20)
        
        button3.autoAlignAxis(.vertical, toSameAxisOf: containerView)
        button3.autoSetDimension(.height, toSize: 44)
        button3.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -32)
        button3.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 20)
        button3.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -20)
    }
}
