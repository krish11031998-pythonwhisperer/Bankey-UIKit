//
//  CustomLabel.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit

class CustomLabel:UILabel{
    
    private var addPadding:Bool
    
    public func setText(_ text:String){
        self.text = text
    }
    
    init(labelText:String,size:CGFloat,weight:UIFont.Weight,color:UIColor = .white,numberOFLines:Int = 0,addPadding:Bool = false){
        
        self.addPadding = addPadding
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
        self.text = labelText
        self.textColor = color
        self.font = .systemFont(ofSize: size, weight: weight)
        self.numberOfLines = numberOFLines
        self.textAlignment = .left
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
