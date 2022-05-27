//
//  MoneyViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit

class MoneyViewController:UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hideNavigationBar()
        
        self.setupStatusBar()
        
        self.view.backgroundColor = .blue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
