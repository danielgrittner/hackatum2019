//
//  LoginScreen.swift
//  Beacon Sample
//
//  Created by Niclas Heun on 23.11.19.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit
import Foundation

class LoginScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc  = UIViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
}

