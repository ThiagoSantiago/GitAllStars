//
//  File.swift
//  GitAllStars
//
//  Created by Thiago Santiago on 2/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit


class GitAllStarsRouter {
    
    var navigation: UINavigationController = UINavigationController()
    
    func routeToHome() {
//        let presenter = MyPresenter()
//        let interactor = MyInteractor()
        let viewController = HomeViewController()
        self.navigation.pushViewController(viewController, animated: false)
    }
}
