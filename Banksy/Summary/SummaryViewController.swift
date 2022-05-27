//
//  HomeViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import UIKit
class SummaryViewController:UIViewController{

    private let txns:[TransactionModel] = [
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 300...1500)),
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 300...1500)),
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 300...1500)),
        .init(type: .banking, description: "Basic Saving", value: Float.random(in: 300...1500)),
        .init(type: .creditCard, description: "Visa Avion Card", value: Float.random(in: 300...1500)),
        .init(type: .creditCard, description: "Student Mastercard", value: Float.random(in: 300...1500))
    ]

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.setupStatusBar()
        self.setupViews()
    }
    
    func setupViews(){
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupLayout()
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
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
    
}
