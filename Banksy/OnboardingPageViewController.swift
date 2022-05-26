//
//  OnboardingPageViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

class OnboardingPageViewController: UIViewController {
    
    private var color:UIColor

    init(color:UIColor){
        self.color = color
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.color
        // Do any additional setup after loading the view.
    }
    
    

}
