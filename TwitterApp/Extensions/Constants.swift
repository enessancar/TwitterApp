//
//  Constants.swift
//  TwitterApp
//
//  Created by Enes Sancar on 30.06.2023.
//

import Foundation

enum Constants: String {
    case twitterLogo = "twitterLogo"
    case likeIcon = "heart"
    case shareIcon = "square.and.arrow.up"
    case retweetIcon = "arrow.2.squarepath"
    case replyIcon = "bubble.left"
    
    enum Onboarding: String {
        case welcomeLabel = "See what's happening in the world right now."
        case createAccount = "Create account"
        case promptLabel = "Have an account already?"
        case login = "Log in"
    }
    
    enum Register: String {
        case registerTitle = "Create your account"
        case email = "Email"
        case password = "Password"
        case createAccount = "Create Account"
    }
    
    enum Home: String {
         case signOut = "rectangle.portrait.and.arrow.right"
    }
    
    enum Login: String {
        case login = "Login to your account"
        case loginButton = "Login"
    }
}
