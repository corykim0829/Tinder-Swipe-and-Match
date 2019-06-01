//
//  MatchView.swift
//  Tinder
//
//  Created by Cory Kim on 28/05/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit
import Firebase

class MatchView: UIView {
    
    var currentUser: User!
    
    var cardUID: String! {
        didSet {
            Firestore.firestore().collection("users").document(cardUID).getDocument { (snapshot, err) in
                if let err = err {
                    print("Failed to fetch matched user data", err)
                    return
                }
                
                guard let dictionary = snapshot?.data() else { return }
                let cardUser = User(dictionary: dictionary)
                guard let url = URL(string: cardUser.imageUrl1 ?? "") else { return }
                self.cardUserImageView.sd_setImage(with: url)
                self.discriptionLable.text = "You and \(cardUser.name ?? "") liked\neach other"
                
                guard let currentUserImageUrl = URL(string: self.currentUser.imageUrl1 ?? "") else { return }
                self.currentUserImageView.sd_setImage(with: currentUserImageUrl, completed: { (_, _, _, _) in
                    self.setupAnimations()
                })
            }
        }
    }
    
    fileprivate let itsaMatchImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "itsamatch"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate let discriptionLable: UILabel = {
        let label = UILabel()
        label.text = "You and X have liked/swiped\neach other"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    fileprivate let currentUserImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "gp1"))
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate let cardUserImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "sh1"))
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate let sendMessageButton: UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("SEND MESSAGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    fileprivate let keepSwipingButton: UIButton = {
        let button = KeepSwipingButton(type: .system)
        button.setTitle("Keep Swiping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBlurView()
        setupLayout()
//        setupAnimations()
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 1
        }) { (_) in
            
        }
    }
    
    fileprivate func setupAnimations() {
        
        let angle = -30 * CGFloat.pi / 180
        
        currentUserImageView.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        cardUserImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        sendMessageButton.transform = CGAffineTransform(translationX: -500, y: 0)
        keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.views.forEach({ $0.alpha = 1 })
        })
        
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45, animations: {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: angle)
                self.cardUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                self.currentUserImageView.transform = .identity
                self.cardUserImageView.transform = .identity
            })
            
        }) { (_) in
            
        }
        
        UIView.animate(withDuration: 0.75, delay: 0.6 * 1.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.sendMessageButton.transform = .identity
            self.keepSwipingButton.transform = .identity
        }) { (_) in
            
        }
    }
    
    lazy var views = [
        itsaMatchImageView,
        discriptionLable,
        currentUserImageView,
        cardUserImageView,
        sendMessageButton,
        keepSwipingButton
    ]
    
    fileprivate func setupLayout() {
        views.forEach({
            $0.alpha = 0
            addSubview($0)
        })
        
        let imageWidth: CGFloat = 140
        
        itsaMatchImageView.anchor(top: nil, leading: nil, bottom: discriptionLable.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 300, height: 80))
        itsaMatchImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        discriptionLable.anchor(top: nil, leading: leadingAnchor, bottom: cardUserImageView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 32, right: 0), size: .init(width: 0, height: 50))
        
        currentUserImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: imageWidth, height: imageWidth))
        currentUserImageView.layer.cornerRadius = imageWidth / 2
        currentUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cardUserImageView.anchor(top: nil, leading: centerXAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: imageWidth, height: imageWidth))
        cardUserImageView.layer.cornerRadius = imageWidth / 2
        cardUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        sendMessageButton.anchor(top: cardUserImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 48, bottom: 0, right: 48), size: .init(width: 0, height: 60))
        sendMessageButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor, leading: sendMessageButton.leadingAnchor, bottom: nil, trailing: sendMessageButton.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))
    }
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    fileprivate func setupBlurView() {
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        self.alpha = 0
    }
    
    @objc fileprivate func handleTapDismiss() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
