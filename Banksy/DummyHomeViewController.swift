//
//  HomeViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit

class DummyHomeViewController: UIViewController {
    
    public weak var delegate:LoginAndOnboardingViewControllerDelegate? = nil
    
    private let headingView:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.textColor = .black
        label.font = .systemFont(ofSize: 45, weight: .medium)
        
        return label
    }()
    
    
    private lazy var logOutButton:CustomButton = {
        let button = CustomButton(buttonTitle: "Log Out")
        button.delegate = self
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        // Do any additional setup after loading the view.
    }
    
    public lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.backgroundColor = .red
        
        stack.addArrangedSubview(self.headingView)
        stack.addArrangedSubview(self.logOutButton)
        
        return stack
    }()
    
    func setupViews(){
        self.view.addSubview(self.stackView)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutViews()
    }
    
    func layoutViews(){
        
        //StackView
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: self.stackView.trailingAnchor, multiplier: 1)
        ])
        
    }

}


extension DummyHomeViewController:CustomButtonDelegate{
    func handleButtonClick(id: String?) {
        self.delegate?.didLogout()
    }
}
