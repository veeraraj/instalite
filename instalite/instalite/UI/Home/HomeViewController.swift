//
//  HomeViewController.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    // MARK: Properties
    
    private let viewModel: HomeViewModel
    private var subscriptions = Set<AnyCancellable>()

    // MARK: Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        viewModel.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel
            .$accountInfo
            .sink { [weak self] accountInfo in
                print("account", accountInfo)
            }
            .store(in: &subscriptions)
    }
}
