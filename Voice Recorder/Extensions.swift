//
//  Extensions.swift
//  My Movies
//
//  Created by Zackary O'Connor on 3/7/19.
//  Copyright © 2019 Zackary O'Connor. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil, textColor: UIColor? = .label, fontSize: CGFloat? = 17, fontWeight: UIFont.Weight? = .regular, textAlignment: NSTextAlignment? = .left, numberOfLines: Int? = 0) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize ?? 17, weight: fontWeight ?? .regular)
        self.textAlignment = textAlignment ?? .left
        self.numberOfLines = numberOfLines ?? 0
    }
}

extension UIImageView {
    convenience init(image: String? = nil, cornerRadius: CGFloat? = 0) {
        self.init(image: nil)
        self.image = UIImage(named: "\(image ?? "")")
        self.layer.cornerRadius = cornerRadius ?? 0
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String? = nil, backgroundColor: UIColor? = nil, setTitleColor: UIColor? = nil, font: UIFont? = nil, cornerRadius: CGFloat? = nil) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(setTitleColor, for: .normal)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius ?? 0
    }
}


extension UITextField {
    convenience init(placeholder: String? = nil, keyboardType: UIKeyboardType? = .default, returnKeyType: UIReturnKeyType? = .default, autocorrectionType: UITextAutocorrectionType? = .default) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.keyboardType = keyboardType ?? .default
        self.returnKeyType = returnKeyType ?? .default
        self.enablesReturnKeyAutomatically = true
        self.autocorrectionType = autocorrectionType ?? .default
    }
}


extension UIView {
    convenience init(backgroundColor: UIColor? = .none) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}


extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0, axis: NSLayoutConstraint.Axis = .vertical) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
        self.axis = axis
    }
}


extension UIActivityIndicatorView {
    convenience init(indicatorColor: UIColor) {
        self.init(style: .large)
        self.color = .darkGray
        self.isHidden = false
        self.startAnimating()
    }
}


extension UIViewController {
    func displayAlertController(title: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}




let imageCache = NSCache<AnyObject, AnyObject>()
var imageUrlString: String?

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }.resume()
    }
}




// Firebase errors codes

//extension AuthErrorCode {
//    var errorMessage: String {
//        switch self {
//        case .emailAlreadyInUse:
//            return "The email is already in use with another account."
//        case .userNotFound:
//            return "Account not found for the specified user. Please check and try again."
//        case .userDisabled:
//            return "Your account has been disabled. Please contact support."
//        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
//            return "Please enter a valid email."
//        case .networkError:
//            return "Network error. Please try again."
//        case .weakPassword:
//            return "Your password is too weak. The password must be 6 characters long or more."
//        case .wrongPassword:
//            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password."
//        case .keychainError:
//            return "looks like there was an error logging out, please try again later."
//        default:
//            return "Unknown error occurred."
//        }
//    }
//}
