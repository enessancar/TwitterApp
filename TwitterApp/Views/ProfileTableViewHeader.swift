//
//  ProfileTableViewHeader.swift
//  TwitterApp
//
//  Created by Enes Sancar on 30.06.2023.
//

import UIKit
import SnapKit

final class ProfileTableViewHeader: UIView {
    
    //MARK: - Properties
    private lazy var profileHeaderImageView = CustomImage(frame: .zero)
    private lazy var profileAvatarImageView = CustomImage(cornerRadius: 40)
    private lazy var displayNameLabel = CustomLabel(fontSize: 22, weight: .bold, textColor: .label)
    private lazy var usernameLabel = CustomLabel(fontSize: 18, weight: .regular, textColor: .secondaryLabel)
    private lazy var userBiolabel = CustomLabel(textColor: .label, numberOfLines: 3)
    
    private lazy var joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    private lazy var joinDateLabel = CustomLabel(fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubviewsList(
            [
                profileHeaderImageView, profileAvatarImageView, displayNameLabel, usernameLabel, userBiolabel, joinDateImageView, joinDateLabel
            ])
        
        profileHeaderImageView.image = UIImage(named: "image")
        profileAvatarImageView.image = UIImage(systemName: "person")
        displayNameLabel.text = "Enes Sacnarr"
        usernameLabel.text = "@enes5775"
        userBiolabel.text = "ALIŞIRIM SANMIŞTIM"
        joinDateLabel.text = "23.21.2222"
    }
    
    private func configureConstraints() {
        profileHeaderImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(180)
        }
        
        profileAvatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(profileHeaderImageView.snp.bottom)
            make.width.height.equalTo(80)
        }
        
        displayNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileAvatarImageView.snp.leading)
            make.top.equalTo(profileAvatarImageView.snp.bottom).offset(20)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(displayNameLabel.snp.leading)
            make.top.equalTo(displayNameLabel.snp.bottom).offset(5)
        }
        
        userBiolabel.snp.makeConstraints { make in
            make.leading.equalTo(displayNameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
        }
        
        joinDateImageView.snp.makeConstraints { make in
            make.leading.equalTo(displayNameLabel.snp.leading)
            make.top.equalTo(userBiolabel.snp.bottom).offset(5)
        }
        
        joinDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(joinDateImageView.snp.trailing).offset(4)
            make.bottom.equalTo(joinDateImageView.snp.bottom)
        }
    }
}
