//
//  HomeVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 27.06.2023.
//

import UIKit
import FirebaseAuth
import Combine

final class HomeVC: UIViewController {
    
    private var viewModel = HomeViewViewModel()
    private var subscription: Set<AnyCancellable> = []
    
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
        configureView()
    }
    
    private func configureView() {
        configureTableView()
        configureNavigationBar()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.Home.signOut.rawValue), style: .plain, target: self, action: #selector(didTapSignOut))
        
        bindViews()
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retreiveUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
    }
    
    private func configureTableView() {
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }
    
    func completeUserOnboarding() {
        let vc = ProfileDataFormVC()
        present(vc, animated: true)
    }
    
    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let self else { return }
            guard let user = user else { return }
            if !user.isUserOnboarded {
                self.completeUserOnboarding()
            }
        }
        .store(in: &subscription)
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
    
    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }
}
