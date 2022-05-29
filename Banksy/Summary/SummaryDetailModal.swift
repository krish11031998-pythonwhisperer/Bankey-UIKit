//
//  SummaryDetailModal.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 29/05/2022.
//

import Foundation
import UIKit



class SummaryDetailModal:UIView{
    
    var summaryDetail:TransactionModel? = nil
    
    public var delegate:CustomButtonDelegate?
    
    // MARK: Views
    private lazy var heading = CustomLabel(labelText: "", size: 15, weight: .bold, color: .black, numberOFLines: 1, addPadding: false)
    
    private lazy var descriptionLabel = CustomLabel(labelText: "", size: 17.5, weight: .medium, color: .black, numberOFLines: 2, addPadding: false)
    
    private lazy var amountLabel = CustomLabel(labelText: "", size: 25, weight: .bold, color: .black, numberOFLines: 1, addPadding: false)
    
    private lazy var header:UIStackView = {
        let closeButton = CustomButton(buttonTitle: "Close",buttonId: "modal_close")
        closeButton.delegate = self
        
        let view = UIStackView()
        view.spacing = 5
        
        view.addArrangedSubview(self.heading)
        view.addArrangedSubview(closeButton)
        
        NSLayoutConstraint.activate([
            self.heading.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -55),
            closeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        return view
    }()
    
    private lazy var amountLabelStack:UIStackView = {
        let decortatorLabel = CustomLabel(labelText: "Amount : ", size: 20, weight: .regular, color: .black, numberOFLines: 1, addPadding: false)
        
        let view = UIStackView()
        view.spacing = 5
        
        
        view.addArrangedSubview(decortatorLabel)
        view.addArrangedSubview(amountLabel)
        
        self.amountLabel.textAlignment = .right
        
        NSLayoutConstraint.activate([
            decortatorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5,constant: -2.5),
            amountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5,constant: -2.5)
        ])
        
        return view
        
    }()

    private lazy var summaryDetailStack:UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 5
        
        
        view.addArrangedSubview(self.header)
        view.addArrangedSubview(self.descriptionLabel)
        view.addArrangedSubview(self.amountLabelStack)
        
        NSLayoutConstraint.activate([
            self.header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2,constant: -2.5),
            self.descriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3,constant: -5),
            self.amountLabelStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5,constant: -2.5)
        ])
        
        return view
    }()
    
    //MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.layer.borderWidth = 1
        
        self.setupView()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.addSubview(self.summaryDetailStack)
    }
    
    func setupLayout(){
        self.summaryDetailStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 15).isActive = true
        self.summaryDetailStack.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        self.summaryDetailStack.widthAnchor.constraint(equalTo: self.widthAnchor,constant: -30).isActive = true
        self.summaryDetailStack.heightAnchor.constraint(equalTo: self.heightAnchor,constant: -20).isActive = true
    }
    
    public func updateModal(txn:TransactionModel){
        self.heading.text = txn.type.rawValue
        self.descriptionLabel.text = txn.description
        self.amountLabel.attributedText = CurrencyFormatter().fancyAttributedString(txn.value)
    }
    
}


//MARK: - CustomButtonDelegate
extension SummaryDetailModal:CustomButtonDelegate{
    func handleButtonClick(id: String?) {
        self.delegate?.handleButtonClick(id: id)
    }
    
}

