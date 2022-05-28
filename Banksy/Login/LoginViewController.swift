//
//  ViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

protocol LoginOnboardingDelegate:AnyObject{
    func didLogin()
    func didLogout()
    func didFinishOnboarding()
}

class LoginViewController: UIViewController {

    
    private let loginView = LoginView()
    
    private var welcomeSectionLeadingAnchor:NSLayoutConstraint? = nil
    private let leadingEdgeOnScreen:CGFloat = 8
    private let leadingEdgeOffScreen:CGFloat = -1000
    
    public weak var delegate:LoginOnboardingDelegate? = nil
    
    // MARK: - Views
    private lazy var titleView:CustomLabel = .init(labelText: "Bankey", size: 25, weight: .medium, color: .black, numberOFLines: 1)
    
    private lazy var messageView:CustomLabel = .init(labelText: "You're premium source for all things banking!", size: 15, weight: .regular, color: .black, numberOFLines: 2)
    
    
    private lazy var WelcomeMessageView:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleView.alpha = 0
        self.titleView.textAlignment = .center
        stack.addArrangedSubview(self.titleView)
        
        self.messageView.alpha = 0
        self.messageView.textAlignment = .center
        
        stack.addArrangedSubview(self.messageView)
        
        return stack
    }()
    
    private var errorMessage:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private lazy var signInButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.imagePadding = 8
        button.setTitle("SignIn", for: [])
        button.addTarget(self, action: #selector(self.signInTapped), for: .primaryActionTriggered)
        return button
       
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        self.layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if var config = self.signInButton.configuration,config.showsActivityIndicator{
            config.showsActivityIndicator.toggle()
        }
        self.animate()
    }

    public func resetLoginViewController(){
        if let _  = self.signInButton.configuration?.showsActivityIndicator{
            self.signInButton.configuration?.showsActivityIndicator = false
        }
        
        self.loginView.resetTextFields()
    
    }

}

// MARK: - Animation
extension LoginViewController{
    private func animate(){
        let duration:TimeInterval = 1
        let animation = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.welcomeSectionLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animation.startAnimation()
        
        let textAlphaAnimation = UIViewPropertyAnimator(duration: duration * 1.5, curve: .easeInOut) {
            self.titleView.alpha = 1
            self.messageView.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        textAlphaAnimation.startAnimation(afterDelay: duration * 0.25)
        
    }
}

// MARK: - Miscellaneous
extension LoginViewController{
    
    private func setupView(){
        self.loginView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.loginView)
        self.view.addSubview(self.signInButton)
        self.view.addSubview(self.errorMessage)
        self.view.addSubview(self.WelcomeMessageView)
    }
    
    private func layout(){
        
        //loginView
        NSLayoutConstraint.activate([
            self.loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: self.loginView.trailingAnchor, multiplier: 1),
        ])
        
        //SignInButton
        NSLayoutConstraint.activate([
            self.signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            self.signInButton.topAnchor.constraint(equalToSystemSpacingBelow: self.loginView.bottomAnchor, multiplier: 2),
            self.signInButton.trailingAnchor.constraint(equalTo: self.loginView.trailingAnchor)
        ])
        
        
        //ErrorLabel
        NSLayoutConstraint.activate([
            self.errorMessage.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            self.errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: self.signInButton.bottomAnchor, multiplier: 2),
            self.errorMessage.trailingAnchor.constraint(equalTo: self.signInButton.trailingAnchor)
        ])
        
        //WelcomeSection
        NSLayoutConstraint.activate([
            self.loginView.topAnchor.constraint(equalToSystemSpacingBelow: self.WelcomeMessageView.bottomAnchor, multiplier: 3),
            self.WelcomeMessageView.trailingAnchor.constraint(equalTo: self.loginView.trailingAnchor),
        ])
        
        self.welcomeSectionLeadingAnchor = self.WelcomeMessageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.leadingEdgeOffScreen)
        self.welcomeSectionLeadingAnchor?.isActive = true
        
    }
    
    @objc func signInTapped(_ sender:UIButton!){
        print("Clicked on signIn!")
        let (username,password) = self.loginView.loginCredentialsCheck()
        
        guard let safeUsername = username,let safePassword = password else {
            assertionFailure("username/password can never be nil")
            return
        }
        
        if safeUsername.isEmpty && safePassword.isEmpty {
            self.configErrorView("Username & Password is empty")
        }else if safeUsername.isEmpty {
            self.configErrorView("Username is empty")
        }else if safePassword.isEmpty {
            self.configErrorView("Password is empty")
        }else{
            self.configErrorView("")
            if safeUsername == "test" && safePassword == "welcome"{
                self.signInButton.configuration?.showsActivityIndicator = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.delegate?.didLogin()
                    self.resetLoginViewController()
                }
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.configErrorView("Incorrect Credentials")
                    self.resetLoginViewController()
                }
                
            }
        }
        
    }
    
    func configErrorView(_ withMessage:String){
        self.errorMessage.text = withMessage
        self.errorMessage.isHidden = withMessage.isEmpty
    }
    
}

