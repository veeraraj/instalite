//
//  HomeViewController.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: Properties
    
    private let viewModel: HomeViewModel

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
    }
}
