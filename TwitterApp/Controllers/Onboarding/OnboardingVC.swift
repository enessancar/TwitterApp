//
//  OnboardingVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 4.07.2023.
//

import UIKit
import SnapKit

final class OnboardingVC: UIViewController {
    
    //MARK: - Properties
    private lazy var welcomeLabel = CustomLabel(text: Constants.Onboarding.welcomeLabel.rawValue, textColor: .label ,fontSize: 32, weight: .heavy, textAlignment: .center)
    
    private let createAccountButton = CustomButton(title: Constants.Onboarding.createAccount.rawValue, tintColor: .white, backgroundColor: Colors.twitterBlue, fontSize: 24, weight: .bold, cornerRadius: 30)
    
    private lazy var promptLabel = CustomLabel(text: Constants.Onboarding.promptLabel.rawValue, textColor: .gray, fontSize: 14, weight: .regular)
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Onboarding.login.rawValue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.tintColor = Colors.twitterBlue
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }
}

extension OnboardingVC {
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(welcomeLabel, createAccountButton, promptLabel, loginButton)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(welcomeLabel)
            make.height.equalTo(60)
        }
        
        promptLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(promptLabel.snp.trailing).offset(10)
            make.centerY.equalTo(promptLabel.snp.centerY)
        }
    }
}

//MARK: - Objc Func
extension OnboardingVC {
    @objc
    private func didTapCreateAccount() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func didTapLogin() {
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
