//
//  HomeViewController.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    private struct Constants {
        static let userIcon = "person.crop.circle"
        static let cellIdentifier = "mediaCell"
        static let reloadIcon = "arrow.counterclockwise"
    }
    // MARK: Properties
    
    private let viewModel: HomeViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: UI Elements
    
    private lazy var accountInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .theme(.accountInfoBackground)
        
        return view
    }()
    
    private lazy var accountInfoImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: Constants.userIcon)
        imageview.tintColor = .theme(.imageTint)
        
        return imageview
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .theme(.defaultText)
        label.font = .systemFont(ofSize: 24)
        label.text = " "
        
        return label
    }()
    
    private lazy var postCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .theme(.defaultText)
        label.font = .systemFont(ofSize: 14)
        label.text = " "
        
        return label
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 32)
        let reloadButtonImage = UIImage(systemName: Constants.reloadIcon, withConfiguration: configuration)
        button.setImage(reloadButtonImage, for: .normal)
        button.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
        button.tintColor = .theme(.imageTint)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        viewLayout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .theme(.pageBackground)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        
        return collectionView
    }()
    
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
        configureView()
        configureConstraints()
        bind()
        viewModel.viewDidLoad()
    }
    
    // MARK: private Methods
    
    @objc
    private func didTapReload() {
        viewModel.didTapReload()
    }
    
    private func configureView() {
        view.addSubview(accountInfoView)
        accountInfoView.addSubview(accountInfoImageView)
        accountInfoView.addSubview(userNameLabel)
        accountInfoView.addSubview(postCountLabel)
        accountInfoView.addSubview(reloadButton)
        view.addSubview(collectionView)
    }
    
    private func bind() {
        viewModel.didReceieveAccountInfo = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let accountInfo = self.viewModel.accountInfo else { return }
                self.postCountLabel.text = "Posts: \(accountInfo.media_count)"
                self.userNameLabel.text = accountInfo.username
            }
        }
        
        viewModel.didReceiveError = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showInfoAlert(message: self.viewModel.error?.localizedDescription ?? NetworkError.unknown.localizedDescription)
            }
        }
        
        viewModel.didReceieveMediaInfo = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configureConstraints() {
        accountInfoView.activate(constraints: [
            accountInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            accountInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountInfoView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        reloadButton.activate(constraints: [
            reloadButton.bottomAnchor.constraint(equalTo: accountInfoView.bottomAnchor, constant: -16),
            reloadButton.trailingAnchor.constraint(equalTo: accountInfoView.trailingAnchor, constant: -16),
            reloadButton.heightAnchor.constraint(equalToConstant: 32),
            reloadButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        accountInfoImageView.activate(constraints: [
            accountInfoImageView.topAnchor.constraint(equalTo: accountInfoView.topAnchor, constant: 48),
            accountInfoImageView.leadingAnchor.constraint(equalTo: accountInfoView.leadingAnchor, constant: 16),
            accountInfoImageView.heightAnchor.constraint(equalToConstant: 100),
            accountInfoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        userNameLabel.activate(constraints: [
            userNameLabel.centerYAnchor.constraint(equalTo: accountInfoImageView.centerYAnchor, constant: -16),
            userNameLabel.leadingAnchor.constraint(equalTo: accountInfoImageView.trailingAnchor, constant: 16),
            userNameLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        postCountLabel.activate(constraints: [
            postCountLabel.centerYAnchor.constraint(equalTo: accountInfoImageView.centerYAnchor, constant: 16),
            postCountLabel.leadingAnchor.constraint(equalTo: accountInfoImageView.trailingAnchor, constant: 16),
            postCountLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        collectionView.activate(constraints: [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: accountInfoView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.mediaInfo?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        if let mediaItem = viewModel.mediaInfo?.data[indexPath.row] {
            cell.setup(with:mediaItem)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let mediaItem = viewModel.mediaInfo?.data[indexPath.row] else { return }
        viewModel.didTapMediaItem(mediaItem)
    }
}
