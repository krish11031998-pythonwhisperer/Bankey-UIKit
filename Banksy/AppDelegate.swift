//
//  AppDelegate.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var userLoggedIn:Bool{
        get{
            return UserDefaults.standard.bool(forKey: "Bankey_userLoggedIn")
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: "Bankey_userLoggedIn")
        }
    }

    
    var userFinishedOnboarding:Bool{
        get{
            return UserDefaults.standard.bool(forKey: "Bankey_userFinishedOnboarding")
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: "Bankey_userFinishedOnboarding")
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        if self.userLoggedIn{
            self.setWindowRootViewController(rootViewController: self.homeVC, animated: true)
            self.homeVC.setupStatusBar()
        }else{
            self.setWindowRootViewController(rootViewController: self.loginVC, animated: true)
        }
        
        self.registerNotificationCenter()
        
        return true
    }

    private lazy var loginVC:LoginViewController = {
        let loginVC = LoginViewController()
        loginVC.delegate = self
        return loginVC
    }()
    
    
    private lazy var onboardingVC:OnboardingContainerViewController = {
        let onboardingVC = OnboardingContainerViewController()
        onboardingVC.delegate = self
        return onboardingVC
    }()
    
    private lazy var homeVC:MainViewController = {
        let homeVC = MainViewController()
        homeVC.loginDelegate = self
        return homeVC
    }()
    
    private func setWindowRootViewController(rootViewController vc:UIViewController,animated:Bool){
        guard let safeWindow = self.window else {return}
        
        safeWindow.rootViewController = vc
        safeWindow.makeKeyAndVisible()
        
        if animated{
            UIView.transition(with: safeWindow,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: nil,
                                  completion: nil)
        }
    }
}

// MARK: - NotificationCenter
extension AppDelegate{
    func registerNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.logoutUser(_:)), name: .logout, object: nil)
    }
    
    @objc func logoutUser(_ sender:UIButton!){
        self.didLogout()
    }
}

// MARK: - LoginAndOnboardingViewControllerDelegate
extension AppDelegate:LoginOnboardingDelegate{
    func didLogin() {
        if !self.userLoggedIn{
            self.userLoggedIn.toggle()
            if self.userFinishedOnboarding{
                self.setWindowRootViewController(rootViewController: self.homeVC, animated: true)
            }else{
                self.setWindowRootViewController(rootViewController: self.onboardingVC, animated: true)
            }
        }
    }
    
    func didLogout() {
        if self.userLoggedIn{
            self.userLoggedIn.toggle()
            self.setWindowRootViewController(rootViewController: self.loginVC, animated: true)
        }
    }
    
    func didFinishOnboarding() {
        if !self.userFinishedOnboarding{
            self.userFinishedOnboarding.toggle()
            self.setWindowRootViewController(rootViewController: self.homeVC, animated: true)
        }
    }

}

