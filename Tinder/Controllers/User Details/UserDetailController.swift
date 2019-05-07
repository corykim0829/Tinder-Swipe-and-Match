//
//  UserDetailController.swift
//  Tinder
//
//  Created by Cory Kim on 05/05/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailController: UIViewController, UIScrollViewDelegate {
    
    // you should really create a different ViewModel object for UserDetails
    // ie UserDetailViewModel
    var cardViewModel: CardViewModel! {
        didSet {
            infoLabel.attributedText = cardViewModel.attributedString
            
            guard let firstImageUrl = cardViewModel.imageUrls.first, let url = URL(string: firstImageUrl) else { return }
            imageView.sd_setImage(with: url)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "gp3"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Username, 40\nDoctor\nSome bio text down below"
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        scrollView.addSubview(imageView)
        // frame
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        
        scrollView.addSubview(infoLabel)
        infoLabel.anchor(top: imageView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        var width = view.frame.width + changeY * 2
        print(-changeY)
        width = max(view.frame.width, width)
        imageView.frame = CGRect(x: min(0, -changeY), y: min(0, -changeY), width: width, height: width)
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.dismiss(animated: true)
    }

}
