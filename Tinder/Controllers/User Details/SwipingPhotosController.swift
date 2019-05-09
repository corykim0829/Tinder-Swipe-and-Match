//
//  SwipingPhotosController.swift
//  Tinder
//
//  Created by Cory Kim on 09/05/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource {

    var cardViewModel: CardViewModel! {
        didSet {
            controllers = cardViewModel.imageUrls.map({ PhotoController(imageUrl: $0) })
            setViewControllers([controllers.first!], direction: .forward, animated: false)
        }
    }
    
    var controllers = [PhotoController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        view.backgroundColor = .white
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }
    
    class PhotoController: UIViewController {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ms1"))
        
        init(imageUrl: String) {
            super.init(nibName: nil, bundle: nil)
            if let url = URL(string: imageUrl) {
                imageView.sd_setImage(with: url)
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(imageView)
            imageView.fillSuperview()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
