//
//  ProfileVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 30.06.2023.
//

import UIKit

final class ProfileVC: UIViewController {
    
    //MARK: - Properties
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifer)
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        configureConstraints() 
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
    }
    
    private func configureTableView() {
        view.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        let headerView = ProfileTableViewHeader(frame: .init(x: 0, y: 0, width: profileTableView.frame.width, height: 380))
        profileTableView.tableHeaderView = headerView
        
    }
    
    private func configureConstraints() {
        profileTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



//MARK: - TableView Delegate/DataSource
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifer, for: indexPath) as? TweetTableViewCell else {
            fatalError()
        }
        return cell
    }
}
