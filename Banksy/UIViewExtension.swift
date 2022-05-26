//
//  UIViewExtension.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

extension UIView{
    func buttonBuilder(buttonText:String) -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.setTitle(buttonText, for: .normal)
        button.titleLabel?.textColor = .gray
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            button.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 1),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 1)
        ])
        
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        
        return view
    }
}
