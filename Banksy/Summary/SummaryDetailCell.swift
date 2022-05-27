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
//            self.titleView.setText(Array(repeating: txn.description, count: 1).reduce("", {$0.isEmpty ? $1 : $0 +  " " + $1}))
            if let dollars = "\(txn.value)".split(separator: ".").first, let cents = "\(txn.value)".split(separator: ".").last{
                self.balanceValueView.attributedText = self.makeFancyAttributedText(dollars: String(dollars), cents: String(cents))
            }
            
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
    
    private var titleView:CustomLabel = CustomLabel(labelText: "", size: 17.5, weight: .medium,color: .black, numberOFLines: 3,addPadding: false)
    
    
    // MARK: - BalanceView
    private lazy var balanceTypeDescriptor:CustomLabel = CustomLabel(labelText: "", size: 12, weight: .medium, color: .black, numberOFLines: 1, addPadding: false)
    
    private lazy var balanceValueView:CustomLabel = CustomLabel(labelText: "", size: 25, weight: .medium, color: .black, numberOFLines: 1, addPadding: false)
    
    
//    private lazy var testStackView:UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
////        stackView.alignment = .center
//        stackView.distribution = .equalSpacing
//
//        stackView.backgroundColor = .black
//
//        let redView = UIView()
//        redView.translatesAutoresizingMaskIntoConstraints = false
//        redView.backgroundColor = .red
//
//        let blueView = UIView()
//        blueView.translatesAutoresizingMaskIntoConstraints = false
//        blueView.backgroundColor = .blue
//
//        let greenView = UIView()
//        greenView.translatesAutoresizingMaskIntoConstraints = false
//        greenView.backgroundColor = .green
//
//        stackView.addArrangedSubview(redView)
//        stackView.addArrangedSubview(blueView)
//        stackView.addArrangedSubview(greenView)
//
//        NSLayoutConstraint.activate([
//            redView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25),
//            blueView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5),
//            greenView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25)
//        ])
//
//        return stackView
//
//    }()
    
    // MARK: - StackViewLayout
    private lazy var balanceValueAndTypeView:UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(self.balanceTypeDescriptor)
        stackView.addArrangedSubview(self.balanceValueView)

        NSLayoutConstraint.activate([
            self.balanceValueView.heightAnchor.constraint(equalTo:self.balanceTypeDescriptor.heightAnchor,multiplier: 1.5)
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
        stack.spacing = 5
        
        stack.addArrangedSubview(self.balanceValueAndTypeView)
        stack.addArrangedSubview(self.button)
        
        NSLayoutConstraint.activate([
            self.balanceValueAndTypeView.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.85),
            self.button.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.15,constant: -5)
        ])

        return stack

    }()
    
    private func setupViews(){
        self.addSubview(self.txnTypeView)
        self.addSubview(self.titleView)
        self.addSubview(self.balanceView)
//        self.addSubview(self.testStackView)
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
            self.titleView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            self.titleView.topAnchor.constraint(equalToSystemSpacingBelow: self.txnTypeView.bottomAnchor, multiplier: 2),
            self.titleView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.5),
        ])

        NSLayoutConstraint.activate([
            self.balanceView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: self.balanceView.trailingAnchor, multiplier: 1),
//            self.balanceView.heightAnchor.constraint(equalTo:self.titleView.heightAnchor,multiplier: 0.5)
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
    
    private func makeFancyAttributedText(dollars:String,cents:String) -> NSMutableAttributedString{
        
        let dollarSignAttribute:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .callout),.baselineOffset:8]
        let dollarAttribute:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .title1)]
        let centAttribute:[NSMutableAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .footnote),.baselineOffset:8]
        
        let rootText:NSMutableAttributedString = .init(string: "$", attributes: dollarSignAttribute)
        rootText.append(.init(string: dollars, attributes: dollarAttribute))
        rootText.append(.init(string: cents, attributes: centAttribute))
        
        return rootText
    }
}
