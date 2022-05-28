//
//  StylizedButton.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

protocol CustomButtonDelegate:AnyObject{
    func handleButtonClick(id:String?)
}

class CustomButton:UIView{

    var delegate:CustomButtonDelegate? = nil
    
    init(buttonTitle:String,buttonId:String? = nil){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.buttonText.text = buttonTitle
        
        if let safeButtonId = buttonId{
            self.accessibilityIdentifier = safeButtonId
        }else{
            self.accessibilityIdentifier = buttonTitle
        }
        
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
    }
    
    private lazy var buttonText:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public func updateLabelText(_ text:String){
        self.buttonText.text = text
    }
    
    @objc func onButtonTapHandle(_ sender:UIButton!){
        print("(DEBUG) Clicked on the \(self.buttonText.text ?? "no_button_name")!")
        self.delegate?.handleButtonClick(id:self.accessibilityIdentifier)
    }
    
    func setupView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onButtonTapHandle))
        self.addGestureRecognizer(tapGesture)
        self.addSubview(self.buttonText)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
    override var intrinsicContentSize: CGSize{
        return .init(width: 45, height: 25)
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            buttonText.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            buttonText.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: buttonText.trailingAnchor, multiplier: 1),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: buttonText.bottomAnchor, multiplier: 1),
        ])
    }

}
