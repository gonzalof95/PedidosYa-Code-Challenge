//
//  BaseViewController.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setNavBar(_ color: UIColor) {
        navigationController?.navigationBar.backgroundColor = color
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: Constants.mainFont, size: 20)]
      
        navigationItem.largeTitleDisplayMode = .never
        
        let backImage = UIImage(named: "backButton")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.backItem?.title = "Custom"
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setStatusBar(_ color: UIColor) {
        let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
        }
        
        statusBar.backgroundColor = color
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        
        statusBar.autoresizingMask = .flexibleWidth
        statusBar.autoresizingMask = .flexibleTopMargin
        
        UIApplication.shared.keyWindow?.addSubview(statusBar)
    }
}
