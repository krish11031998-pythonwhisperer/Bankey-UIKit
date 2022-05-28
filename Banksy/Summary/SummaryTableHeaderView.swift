//
//  SummaryTableheaderView.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit

class SummaryTableHeaderView:UIView{
    
    private let userName:CustomLabel = CustomLabel(labelText: "", size: 15, weight: .medium, numberOFLines: 1,addPadding: false)
    
    private var size:CGSize
    
    private lazy var userInfoStack:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        
        
        let bankeyLabel = CustomLabel(labelText: "Bankey", size: 25, weight: .regular, numberOFLines: 1,addPadding: false)

        let gmlabel = CustomLabel(labelText: "Good Morning,", size: 15, weight: .regular, numberOFLines: 1,addPadding: false)
    
        let dateLabel = CustomLabel(labelText: Date().ISO8601Format(), size: 12.5, weight: .medium, numberOFLines: 1,addPadding: false)
        
        stack.addArrangedSubview(bankeyLabel)
        stack.addArrangedSubview(gmlabel)
        stack.addArrangedSubview(self.userName)
        stack.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            gmlabel.heightAnchor.constraint(equalTo: bankeyLabel.heightAnchor),
            self.userName.heightAnchor.constraint(equalTo: bankeyLabel.heightAnchor),
            dateLabel.heightAnchor.constraint(equalTo: bankeyLabel.heightAnchor)
        ])
        
        return stack
    }()
    
    private lazy var headerView:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        
        stack.addArrangedSubview(self.userInfoStack)
        
        let imageView = UIImageView(image: .init(named: "world"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        stack.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            self.userInfoStack.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5,constant: -10)
        ])
    
        return stack
    }()
    
    init(userName:String,frame:CGRect = .init(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 125))){
    
        self.size = frame.size
        
        super.init(frame: frame)
    
        self.userName.setText(userName)
        self.backgroundColor = .systemTeal
        self.addSubview(self.headerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
    }
    
    override var intrinsicContentSize: CGSize{
        return self.size
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            self.headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8),
            self.headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8),
            self.headerView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            self.headerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8)
        ])
    }
    
}
