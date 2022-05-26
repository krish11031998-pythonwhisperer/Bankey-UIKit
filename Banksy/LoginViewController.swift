//
//  ViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

protocol LoginAndOnboardingViewControllerDelegate:AnyObject{
    func didLogin()
    func didLogout()
    func didFinishOnboarding()
}

class LoginViewController: UIViewController {

    
    private let loginView = LoginView()
    
    public weak var delegate:LoginAndOnboardingViewControllerDelegate? = nil
    
    private let WelcomeMessageView:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleView = UILabel()
        titleView.text = "Bankey"
        titleView.textAlignment = .center
        titleView.font = .systemFont(ofSize: 25, weight: .medium)
        titleView.textColor = .black
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(titleView)
        
        let messageView = UILabel()
        messageView.text = "You're premium source for all things banking!"
        messageView.textAlignment = .center
        messageView.font = .systemFont(ofSize: 15, weight: .regular)
        messageView.textColor = .black
        messageView.numberOfLines = 2
        messageView.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(messageView)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if var config = self.signInButton.configuration,config.showsActivityIndicator{
            config.showsActivityIndicator.toggle()
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layout()
    }

    public func resetLoginViewController(){
        if let _  = self.signInButton.configuration?.showsActivityIndicator{
            self.signInButton.configuration?.showsActivityIndicator = false
        }
        
        self.loginView.resetTextFields()
    
    }

}


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
            self.WelcomeMessageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 5),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: self.WelcomeMessageView.trailingAnchor, multiplier: 5),
            self.WelcomeMessageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }
    
    @objc func signInTapped(){
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

