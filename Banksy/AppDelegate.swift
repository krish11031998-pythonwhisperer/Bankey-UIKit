//
//  AppDelegate.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
//    var userLoggedIn:Bool = false
//    var userFinishedOnboarding:Bool = false
    
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
        }else{
            self.setWindowRootViewController(rootViewController: self.loginVC, animated: true)
        }
        

        
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
    
    private lazy var homeVC:DummyHomeViewController = {
        let homeVC = DummyHomeViewController()
        homeVC.delegate = self
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

extension AppDelegate:LoginAndOnboardingViewControllerDelegate{
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

