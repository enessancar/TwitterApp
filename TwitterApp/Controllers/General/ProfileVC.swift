//
//  ProfileVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 30.06.2023.
//

import UIKit

final class ProfileVC: UIViewController {
    
    private var isStatusBarHidden: Bool = true
    
    //MARK: - Properties
    private lazy var statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
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
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTableView() {
        view.addSubviews(profileTableView, statusBar)
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.contentInsetAdjustmentBehavior = .never
        
        let headerView = ProfileTableViewHeader(frame: .init(x: 0, y: 0, width: profileTableView.frame.width, height: 380))
        profileTableView.tableHeaderView = headerView
        
    }
    
    private func configureConstraints() {
        profileTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        statusBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(view.bounds.height > 800 ? 40 : 20 )
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        if yPosition > 150 && statusBar.isHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                guard let self else { return }
                self.statusBar.layer.opacity = 1
            }
        } else if yPosition < 0 && !isStatusBarHidden {
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
                guard let self else { return }
                self.statusBar.layer.opacity = 0
            }
        }
    }
}
