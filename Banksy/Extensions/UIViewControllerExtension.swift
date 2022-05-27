//
//  UIViewExtension.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

extension UIViewController{

    func setTabBarItem(imageName:String,title:String,tag:Int,systemImage:Bool = true){
        let config = UIImage.SymbolConfiguration(scale: .large)
        self.tabBarItem = .init(title: title, image: systemImage ? .init(systemName: imageName,withConfiguration:config) : .init(named: imageName), tag: tag)
    }
    
    func setupStatusBar(){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = appColor
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
