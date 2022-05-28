//
//  LoginView.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

class LoginView: UIView {

    private lazy var usernameTextField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.enablePasswordEye()
        
        return textField
    }()
    
    
    private lazy var divider:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        return view
    }()
    
    private lazy var textFieldStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.setupViews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    public func loginCredentialsCheck() -> (username:String?,password:String?){
        return (username:self.usernameTextField.text,password:self.passwordTextField.text)
    }

}


extension LoginView{
    
    func setupViews(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .orange
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.35)
        
        self.textFieldStackView.addArrangedSubview(self.usernameTextField)
        self.textFieldStackView.addArrangedSubview(self.divider)
        self.textFieldStackView.addArrangedSubview(self.passwordTextField)
        
        self.addSubview(self.textFieldStackView)
    }
    
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            self.textFieldStackView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor,multiplier: 1),
            self.textFieldStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: self.textFieldStackView.trailingAnchor, multiplier: 1),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: self.textFieldStackView.bottomAnchor, multiplier: 1),
        ])
        
        self.divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    public func resetTextFields(){
        if self.usernameTextField.text != ""{
            self.usernameTextField.text = ""
        }
        
        if self.passwordTextField.text != ""{
            self.passwordTextField.text = ""
        }
    }
}


extension LoginView:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField:UITextField) -> Bool{
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
