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
    private let profileHeaderImageView = CustomImage(frame: .zero)
    private let profileAvatarImageView = CustomImage(cornerRadius: 40, contentMode: .scaleAspectFit)
    private let displayNameLabel = CustomLabel(fontSize: 22, weight: .bold, textColor: .label)
    private let usernameLabel = CustomLabel(fontSize: 18, weight: .regular, textColor: .secondaryLabel)
    private let userBiolabel = CustomLabel(textColor: .label, numberOfLines: 3)
    
    private let joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    private let joinDateLabel = CustomLabel(fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    private let followingCountLabel = CustomLabel(fontSize: 14, weight: .bold, textColor: .label)
    private let followingTextLabel = CustomLabel(fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    private let followerCountLabel = CustomLabel(fontSize: 14, weight: .bold, textColor: .label)
    private let followerTextLabel = CustomLabel(fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    
    private let tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"].map { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        return button
    }
    
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
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
                profileHeaderImageView, profileAvatarImageView, displayNameLabel, usernameLabel, userBiolabel, joinDateImageView, joinDateLabel,
                followingCountLabel, followingTextLabel, followerCountLabel, followerTextLabel, sectionStack
            ])
        
        
        profileHeaderImageView.image = UIImage(named: "image")
        profileAvatarImageView.image = UIImage(systemName: "person")
        profileAvatarImageView.backgroundColor = .yellow
        displayNameLabel.text = "Enes Sacnarr"
        usernameLabel.text = "@enes5775"
        userBiolabel.text = "ALIŞIRIM SANMIŞTIM"
        joinDateLabel.text = "23.21.2222"
        followingCountLabel.text = "123"
        followingTextLabel.text = "Following"
        followerTextLabel.text = "Followers"
        followerCountLabel.text = "1234"
    }
    
    private func configureConstraints() {
        profileHeaderImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(150)
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
            make.leading.equalTo(joinDateImageView.snp.trailing).offset(6)
            make.top.equalTo(joinDateImageView.snp.top)
        }
        
        followingCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(displayNameLabel.snp.leading)
            make.top.equalTo(joinDateLabel.snp.bottom).offset(10)
        }
        
        followingTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(followingCountLabel.snp.trailing).offset(4)
            make.bottom.equalTo(followingCountLabel.snp.bottom)
        }
        
        followerCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(followingTextLabel.snp.trailing).offset(8)
            make.bottom.equalTo(followingCountLabel.snp.bottom)
        }
        
        followerTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(followerCountLabel.snp.trailing).offset(4)
            make.bottom.equalTo(followingCountLabel.snp.bottom)
        }
        
        sectionStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalTo(followingCountLabel.snp.bottom).offset(5)
        }
    }
}
