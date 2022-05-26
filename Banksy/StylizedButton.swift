//
//  StylizedButton.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

class CustomButton:UIView{
    
    init(buttonTitle:String){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.button.setTitle(buttonTitle, for: .normal)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
    }
    
    private let button:UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .gray
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupView(){
        self.addSubview(button)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
    override var intrinsicContentSize: CGSize{
        return .init(width: 45, height: 25)
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            button.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 1),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 1),
        ])
    }

}
