//
//  UITextFieldView.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 28/05/2022.
//

import Foundation
import UIKit

extension UITextField {
    
    func enablePasswordEye(){
        
        let passwordToggleButton = UIButton(type: .custom)
        
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"),for: .normal)
        passwordToggleButton.setImage(.init(systemName: "eye.slash.fill"), for: .selected)
        
        passwordToggleButton.addTarget(self, action: #selector(self.showPassword), for: .touchUpInside)
        
        self.rightView = passwordToggleButton
        self.rightViewMode = .always
    }
    
    @objc func showPassword(){
        self.isSecureTextEntry.toggle()
        if let button = self.rightView as? UIButton{
            button.isSelected.toggle()
        }
        
    }
    
}
