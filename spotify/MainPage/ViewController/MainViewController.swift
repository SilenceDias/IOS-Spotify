//
//  MainViewController.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 10.02.2024.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: Properties
    var viewModel: MainViewModel?
    
    //MARK: UI Components
    private let albumsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.text = "New Released Albums"
        label.textAlignment = .left
        return label
    }()
    
    private let recommendedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.text = "Recommended"
        label.textAlignment = .left
        return label
    }()
    
    private let playlistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.text = "Featured Playlists"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var recommendedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecommendedMusicTableViewCell.self, forCellReuseIdentifier: "RecommendedMusicTableViewCell")
        tableView.rowHeight = 64
        tableView.estimatedRowHeight = 64
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var newAlbumsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.register(PlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: "PlaylistsCollectionViewCell")
        view.allowsSelection = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var playlistsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.register(PlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: "PlaylistsCollectionViewCell")
        view.allowsSelection = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        createNavBar()
        setupViewModel()
    }
    
    //MARK: Methods
    private func setupViews(){
        [albumsLabel, recommendedLabel, recommendedTableView, newAlbumsCollectionView, playlistLabel, playlistsCollectionView].forEach {
            view.addSubview($0)
        }
        albumsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(14)
            make.left.right.equalToSuperview().inset(16)
        }
        newAlbumsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(albumsLabel.snp.bottom).inset(8)
            make.height.equalTo(220)
            make.left.right.equalToSuperview()
        }
        playlistLabel.snp.makeConstraints { make in
            make.top.equalTo(newAlbumsCollectionView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        playlistsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(playlistLabel.snp.bottom).inset(8)
            make.height.equalTo(220)
            make.left.right.equalToSuperview()
        }
        recommendedLabel.snp.makeConstraints { make in
            make.top.equalTo(playlistsCollectionView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        recommendedTableView.snp.makeConstraints { make in
            make.top.equalTo(recommendedLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupViewModel(){
        viewModel = MainViewModel()
        viewModel?.loadRecomendedMusics(comletion: {
            self.recommendedTableView.reloadData()
        })
        viewModel?.loadAlbums(comletion: {
            self.newAlbumsCollectionView.reloadData()
        })
        viewModel?.loadPlaylists(comletion: {
            self.playlistsCollectionView.reloadData()
        })
    }
    
    private func createNavBar(){
        navigationController?.navigationBar.tintColor = .white
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        let settingImage = UIImageView()
        settingImage.image = UIImage(systemName: "gearshape")
        settingImage.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: settingImage)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCellsTableView ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendedTableView.dequeueReusableCell(withIdentifier: "RecommendedMusicTableViewCell", for: indexPath) as! RecommendedMusicTableViewCell
        let data = viewModel?.getCellOfTableViewModel(at: indexPath)
        cell.configure(data: data)
        return cell
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.newAlbumsCollectionView{
            return viewModel?.numberOfCellsAlbums ?? 1
        }
        else {
            return viewModel?.numberOfCellsPlaylists ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.newAlbumsCollectionView{
            let cell = newAlbumsCollectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as!
                PlaylistsCollectionViewCell
            let data = viewModel?.getCellOfAlbumsViewModel(at: indexPath)
            cell.configure(data: data)
            return cell
        }
        else {
            let cell = newAlbumsCollectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as!
                PlaylistsCollectionViewCell
            let data = viewModel?.getCellOfPlaylistsViewModel(at: indexPath)
            cell.configure(data: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 220)
    }
}
