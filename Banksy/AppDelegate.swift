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
    var userLoggedIn:Bool = false
    var userFinishedOnboarding:Bool = false

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        window?.rootViewController = self.loginVC
//        window?.rootViewController = OnboardingContainerViewController()
        
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
}

extension AppDelegate:LoginAndOnboardingViewControllerDelegate{
    func didLogin() {
        if !self.userLoggedIn{
            self.userLoggedIn.toggle()
            self.window?.rootViewController = self.onboardingVC
        }
    }
    
    func didLogout() {
        if self.userLoggedIn{
            self.userLoggedIn.toggle()
            self.window?.rootViewController = LoginViewController()
        }
    }
    
    func didFinishOnboarding() {
        if !self.userFinishedOnboarding{
            self.userFinishedOnboarding.toggle()
        }
    }
    
    
}

