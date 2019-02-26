//
//  ListRepositoriesServiceSetup.swift
//  GitAllStars
//
//  Created by Thiago Santiago on 2/26/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum ListRepositoriesServiceSetup: GitAllStarsApiSetupProtocol {
    
    case fetchRepositories()
    
    var endpoint: String {
        switch self {
            
        case .fetchRepositories():
            let url = Constants.baseUrl + "/search/repositories?q=language:swift&sort=stars"
            
            return url
        }
    }
}
