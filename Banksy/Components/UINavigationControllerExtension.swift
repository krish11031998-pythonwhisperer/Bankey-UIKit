//
//  UITabBarControllerExtension.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import Foundation
import UIKit


extension UINavigationController{
    
    func hideNavigationBar(){
        self.navigationBar.shadowImage = .init()
        self.navigationBar.setBackgroundImage(.init(), for: .default)
        self.navigationBar.isTranslucent = false
    }
    
}
