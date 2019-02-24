//
//  HomeViewController.swift
//  GitAllStars
//
//  Created by Thiago Santiago on 2/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    var tableView: UITableView!
    var tableViewData: [String] = []
    private let cellIdentifier: String = "HomeTableViewCell"
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        createViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        self.tableView = UITableView()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        self.tableView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        self.title = "Git All Stars"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.tableViewData.count
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setContent()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
