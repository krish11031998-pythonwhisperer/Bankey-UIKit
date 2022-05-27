//
//  CustomLabel.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit

class CustomLabel:UIView{
    
    private var addPadding:Bool
    
    private let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func setText(_ text:String){
        self.label.text = text
    }
    
    init(labelText:String,size:CGFloat,weight:UIFont.Weight,numberOFLines:Int = 0,addPadding:Bool = true){
        
        self.addPadding = addPadding
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.label.text = labelText
        self.label.font = .systemFont(ofSize: size, weight: weight)
        self.label.numberOfLines = numberOFLines
        self.label.textAlignment = .left
        self.addSubview(self.label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
    }
    
    
    func setupLayout(){
        if self.addPadding{
            NSLayoutConstraint.activate([
                self.label.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: self.addPadding ? 1 : 0),
                self.label.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: self.addPadding ? 1 : 0),
                self.trailingAnchor.constraint(equalToSystemSpacingAfter: self.trailingAnchor, multiplier: self.addPadding ? 1 : 0),
                self.bottomAnchor.constraint(equalToSystemSpacingBelow: self.bottomAnchor, multiplier: self.addPadding ? 1 : 0)
            ])
        }else{
            NSLayoutConstraint.activate([
                self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.label.topAnchor.constraint(equalTo: self.topAnchor),
                self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
    }
}
