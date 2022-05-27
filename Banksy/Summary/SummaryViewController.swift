//
//  HomeViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit

class SummaryViewController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = appColor
        
        self.navigationController?.hideNavigationBar()
        
        self.view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
        
}
