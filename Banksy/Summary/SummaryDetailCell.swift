//
//  SummaryDetail.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import Foundation
import UIKit

class SummaryDetailCell:UITableViewCell{
    
    private var txn:TransactionModel? = nil
    
    public static var identifier:String = "SummaryDetailCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    public func updateView(txn:TransactionModel){
        self.txn = txn
        DispatchQueue.main.async {
            self.txnType.text = txn.type.rawValue
            self.indicatorView.backgroundColor = self.indicatorColor(type: txn.type)
            self.titleView.setText(txn.description)
            self.balanceValueView.setText("\(txn.value)")
            self.balanceTypeDescriptor.setText(self.balanceDescriptor(type: txn.type))
            
        }
    }
    
    // MARK: - Transaction Type
    private var txnType:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black

        return label
    }()
    
    private var indicatorView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private lazy var txnTypeView:UIView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        
        stack.spacing = 5
        
        stack.addArrangedSubview(self.txnType)
        stack.addArrangedSubview(self.indicatorView)
        
        NSLayoutConstraint.activate([
            self.indicatorView.widthAnchor.constraint(equalTo: self.txnType.widthAnchor),
            self.indicatorView.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        return stack
    }()
    
    // MARK: - Transaction Description
    
    private var titleView:CustomLabel = {
        let label =  CustomLabel(labelText: "", size: 17.5, weight: .medium,color: .black, numberOFLines: 2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - BalanceView
    private lazy var balanceTypeDescriptor:CustomLabel = CustomLabel(labelText: "", size: 12, weight: .medium, color: .black, numberOFLines: 1, addPadding: false)
    
    private lazy var balanceValueView:CustomLabel =  CustomLabel(labelText: "", size: 25, weight: .medium, color: .black, numberOFLines: 1, addPadding: false)
    
    private lazy var balanceValueAndTypeView:UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.balanceTypeDescriptor)
        stackView.addArrangedSubview(self.balanceValueView)

        NSLayoutConstraint.activate([
            self.balanceValueView.heightAnchor.constraint(equalTo: self.balanceTypeDescriptor.heightAnchor,multiplier: 1.5)
        ])
        
        return stackView
        
    }()
    
    private lazy var button:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = appColor
        button.addTarget(self, action: #selector(self.buttonHandle), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonHandle(){
        print("(DEBUG) Clicked on the Button Handle")
    }
    
    private lazy var balanceView:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0

        stack.addArrangedSubview(self.balanceValueAndTypeView)
        stack.addArrangedSubview(self.button)

        return stack

    }()
    
    private func setupViews(){
        self.addSubview(self.txnTypeView)
        self.addSubview(self.titleView)
        self.addSubview(self.balanceView)
//        self.addSubview(self.balanceValueAndTypeView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
    }
    
}

extension SummaryDetailCell{
    
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            self.txnTypeView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            self.txnTypeView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            self.txnType.widthAnchor.constraint(equalToConstant: self.frame.width * 0.2),
        ])
        
        
        NSLayoutConstraint.activate([
//            self.titleView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            self.titleView.topAnchor.constraint(equalToSystemSpacingBelow: self.txnTypeView.bottomAnchor, multiplier: 1),
            self.titleView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.5),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: self.titleView.bottomAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            self.balanceView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: self.balanceView.trailingAnchor, multiplier: 1),
            self.balanceView.heightAnchor.constraint(equalTo:self.titleView.heightAnchor,multiplier: 0.5)
        ])
    }
    
    
    private func indicatorColor(type:TransactionType) -> UIColor{
        switch type{
            case .banking:
                return .systemTeal
            case .creditCard:
                return .systemOrange
            case .investment:
                return .systemPurple
        }
    }
    
    
    private func balanceDescriptor(type:TransactionType) -> String{
        switch type{
            case .banking:
                return "Current Balance"
            case .investment:
                return "Value"
            case .creditCard:
                return "Balance"
        }
    }
    
}
