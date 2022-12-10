//
//  AppCoordinator.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(accountInfoRepository: AppRepository.shared.AccountInfoRepository, mediaInfoRepository: AppRepository.shared.MediaInfoRepository)
        viewModel.coordinator =  self
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
        
    func showHome() {
        navigationController.popViewController(animated: true)
    }
}
