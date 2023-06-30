//
//  TweetButton.swift
//  TwitterApp
//
//  Created by Enes Sancar on 28.06.2023.
//

import UIKit

final class TweetButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    convenience init(systemImage: String) {
        self.init(frame: .zero)
        
        setImage(UIImage(systemName: systemImage), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        setTitleColor(.white, for: .normal)
        tintColor = .systemGray2
    }
}
