//
//  HomeViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit
class SummaryViewController:UIViewController{

    private let bottomOffScreen:CGFloat = 1000
    private let bottomOnScreen:CGFloat = 0
    private var cardBottomAnchor:NSLayoutConstraint? = nil
    
    private let txns:[TransactionModel] = [
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 300...1500)),
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 30000...1500000)),
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 300...1500)),
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 3000...15000)),
        .init(type: .creditCard, description: "Visa Avion Card", value: Float.random(in: 3000...15000)),
        .init(type: .creditCard, description: "Student Mastercard", value: Float.random(in: 3000...150000))
    ]

    private lazy var txnModal:SummaryDetailModal = {
        let modal = SummaryDetailModal()
        modal.delegate = self
        return modal
    }()
    
    private lazy var tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SummaryDetailCell.self, forCellReuseIdentifier: SummaryDetailCell.identifier)
        table.separatorStyle = .none
        
        let header = SummaryTableHeaderView(userName: "Krishna")
        
        table.backgroundColor = .systemTeal
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        table.tableHeaderView = header
        
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    private lazy var logoutButton:CustomButton = {
        let button = CustomButton(buttonTitle: "Logout")
        button.delegate = self
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.logoutButton)
        self.setupStatusBar()
        self.setupViews()
        self.setupLayout()
    }
    
   
    
    func setupViews(){
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.txnModal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setupLayout(){
        
        //TableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        //TxnModal
        NSLayoutConstraint.activate([
            self.txnModal.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.txnModal.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25),
        ])
        
        self.cardBottomAnchor = self.txnModal.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.bottomOffScreen)
        self.cardBottomAnchor?.isActive = true
    }
    
    
    func setupSummaryDetailModal(txn:TransactionModel){
        self.txnModal.updateModal(txn: txn)
//        self.txnModal.isHidden = false
        self.showModal()
    }
}

//MARK: - SummaryDetailModal Animation
extension SummaryViewController{
    
    func showModal(){
        let cardAnimation = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.cardBottomAnchor?.constant = self.bottomOnScreen
            self.view.layoutIfNeeded()
        }
        cardAnimation.startAnimation()
    }
    
    func closeModal(){
        let cardAnimation = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.cardBottomAnchor?.constant = self.bottomOffScreen
            self.view.layoutIfNeeded()
        }
        cardAnimation.startAnimation()
    }
}

//MARK: - CustomButton Delegate
extension SummaryViewController:CustomButtonDelegate{
    
    func handleButtonClick(id: String?) {
        guard let id = id else {
            return
        }
        
        if id == "modal_close"{
            self.closeModal()
        }else{
            self.logoutButton.updateLabelText("User has Logged Out")
            NotificationCenter.default.post(name: .logout, object: nil )
        }
        
    }
    
}

extension SummaryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.txns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryDetailCell.identifier, for: indexPath) as? SummaryDetailCell else{
            return UITableViewCell()
        }
        if indexPath.row < self.txns.count{
            cell.updateView(txn: self.txns[indexPath.row])
        }
        cell.backgroundColor = .white
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        self.navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let summaryData = self.txns[indexPath.row]
        self.setupSummaryDetailModal(txn: summaryData)
    }
    
}

