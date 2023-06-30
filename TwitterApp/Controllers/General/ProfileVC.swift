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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
    }
    
    private func configureTableView() {
        view.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
}



//MARK: - TableView Delegate/DataSource
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
