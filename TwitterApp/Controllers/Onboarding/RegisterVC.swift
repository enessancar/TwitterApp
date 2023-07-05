//
//  RegisterVC.swift
//  TwitterApp
//
//  Created by Enes Sancar on 4.07.2023.
//

import UIKit
import SnapKit

final class RegisterVC: UIViewController {
    
    //MARK: - Properties
    private lazy var registerTitleLabel = CustomLabel(text: Constants.Register.registerTitle.rawValue, textColor: .label, fontSize: 32, weight: .bold)
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: Constants.Register.email.rawValue,attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: Constants.Register.password.rawValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton = CustomButton(title: Constants.Register.createAccount.rawValue, tintColor: .white, backgroundColor: .twitterBlue, fontSize: 16, weight: .bold, cornerRadius: 25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }
}

extension RegisterVC {
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(registerTitleLabel, emailTextField, passwordTextField, registerButton)
    }
    
    private func configureConstraints() {
        registerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(registerTitleLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.height.width.centerX.equalTo(emailTextField)
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
    }
}
