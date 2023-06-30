//
//  TweetTableViewCell.swift
//  TwitterApp
//
//  Created by Enes Sancar on 28.06.2023.
//

import UIKit
import SnapKit

protocol TweetTableViewCellDelegate: AnyObject {
    func didTapReply()
    func didTapRetweet()
    func didTapLike()
    func didTapShare()
}

final class TweetTableViewCell: UITableViewCell {
    static let identifer = "TweetTableViewCell"
    private let actionSpacing = 50
    
    weak var delegate: TweetTableViewCellDelegate?
    
    //MARK: - Properties
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var tweetContentTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var displayNameLabel = CustomLabel(fontSize: 18, weight: .bold, textColor: .label)
    private lazy var usernameLabel = CustomLabel(fontSize: 16, weight: .regular, textColor: .secondaryLabel)
    
    private lazy var replyButton = TweetButton(systemImage: Constants.replyIcon.rawValue)
    private lazy var retweetButton = TweetButton(systemImage: Constants.retweetIcon.rawValue)
    private lazy var likeButton = TweetButton(systemImage: Constants.likeIcon.rawValue)
    private lazy var shareButton = TweetButton(systemImage: Constants.shareIcon.rawValue)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [replyButton, retweetButton, likeButton, shareButton])
        stackView.axis = .horizontal
        stackView.spacing = 60
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureButtons()
    }
    
    private func configureButtons() {
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    private func configureView() {
        
        contentView.addSubviewsList([avatarImageView, displayNameLabel, usernameLabel, tweetContentTextLabel, stackView])
        
        displayNameLabel.text = "frewrrefref"
        usernameLabel.text = "wrfw3t3fr3"
        tweetContentTextLabel.text = "enes sfenetegteetg4gttgtgtegtegg4egegt4g4rbahçe"
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(50)
        }
        
        displayNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(displayNameLabel.snp.trailing).offset(10)
            make.centerY.equalTo(displayNameLabel.snp.centerY)
        }
        
        tweetContentTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(displayNameLabel.snp.leading)
            make.top.equalTo(displayNameLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(tweetContentTextLabel.snp.leading)
            make.top.equalTo(tweetContentTextLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Objc Func
extension TweetTableViewCell {
    
    @objc private func didTapReply() {
        delegate?.didTapReply()
    }
    
    @objc private func didTapRetweet() {
        delegate?.didTapRetweet()
    }
    
    @objc private func didTapLike() {
        delegate?.didTapLike()
    }
    
    @objc private func didTapShare() {
        delegate?.didTapShare()
    }
}
