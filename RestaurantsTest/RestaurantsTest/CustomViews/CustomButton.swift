//
//  CustomButton.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        setStyle()
        setShadow()
    }
    
    private func setStyle() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.customColorMain
        titleLabel?.font = UIFont(name: Constants.mainFont, size: 18)
        layer.cornerRadius = 8
        isEnabled = true
        alpha = 1
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        clipsToBounds = true
    }
    
    func activate() {
        print("button activated")
        isEnabled = true
    }
    
    func deactivate() {
        print("button deactivated")
        isEnabled = false
    }
}
