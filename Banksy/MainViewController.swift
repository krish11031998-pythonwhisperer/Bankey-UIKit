//
//  MainViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit

class MainViewController:UITabBarController{

    public weak var loginDelegate:LoginAndOnboardingViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarAppearance()
        self.setupViews()
    }
    
    func setupViews(){
        //SummaryVC
        let summaryNavVC = UINavigationController(rootViewController: SummaryViewController())
        summaryNavVC.setTabBarItem(imageName: "list.dash.header.rectangle", title: "Summary", tag: 0)
        
        //MoneyVC
        let moneyNavVC = UINavigationController(rootViewController:MoneyViewController())
        moneyNavVC.setTabBarItem(imageName: "arrow.left.arrow.right", title: "Money", tag: 1)
        
        //MoreVC
        let moreNavVC = UINavigationController(rootViewController:MoreViewController())
        moreNavVC.setTabBarItem(imageName: "ellipsis.circle", title: "More", tag: 2)

        
        self.setViewControllers([summaryNavVC,moneyNavVC,moreNavVC], animated: false)
    }
    
    
    func setupTabBarAppearance(){
        self.tabBar.tintColor = appColor
        self.tabBar.isTranslucent = false
    }

}
