//
//  HomeVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 27.06.2023.
//

import UIKit
import FirebaseAuth

final class HomeVC: UIViewController {
    
    private func configureNavigationBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: Constants.twitterLogo.rawValue)
        self.navigationItem.titleView = logoImageView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }
    
    //MARK: - Properties
    private lazy var  timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifer)
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    private func configureTableView() {
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
    }
}

//MARK: - UITableView Delegate/DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifer, for: indexPath) as? TweetTableViewCell else {
            fatalError("Cell not found")
        }
        cell.delegate = self
        return cell
    }
}

//MARK: - TweetTableViewCell Delegate
extension HomeVC: TweetTableViewCellDelegate {
    
    func didTapReply() {
        print("")
    }
    
    func didTapRetweet() {
        print("")
    }
    
    func didTapLike() {
        print("")
    }
    
    func didTapShare() {
        print("")
    }
}


//MARK: - Objc Func
extension HomeVC {
    @objc private func didTapProfile() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
