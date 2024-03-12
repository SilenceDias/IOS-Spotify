//
//  MainViewController.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 02.03.2024.
//

import UIKit
import SkeletonView

class MainViewController: BaseViewController {
    //MARK: Properties
    
    var viewModel: MainViewModel?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ ->
            NSCollectionLayoutSection? in
            self.createCollectionLayout(section: sectionIndex)
        }
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(PlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: "PlaylistsCollectionViewCell")
        collection.register(RecommendedMusicTableViewCell.self, forCellWithReuseIdentifier: "RecommendedMusicTableViewCell")
        collection.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader")
        collection.backgroundColor = .clear
        collection.isSkeletonable = true
        return collection
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
        view.addSubview(collectionView)
        navigationItem.setBackBarItem()
        title = "Home"
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupViewModel(){
        viewModel = MainViewModel()
// ы
        let group = DispatchGroup()
        viewModel?.didLoad()
        
        group.enter()
        viewModel?.loadAlbums(comletion: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self?.collectionView.reloadData()
                group.leave()
            }
        })
        
        group.enter()
        viewModel?.loadRecomendedMusics(comletion: { [weak self]  in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self?.collectionView.reloadData()
                group.leave()
            }
        })
        
        group.enter()
        viewModel?.loadPlaylists(comletion: { [weak self]  in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self?.collectionView.reloadData()
                group.leave()
            }
        })
        
//        group.notify(queue: .main) { [weak self] in
//            self?.collectionView.hideSkeleton()
//        }
}
    
    private func createNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
    }
    
    @objc
    private func didTapSettings() {
        let controller = SettingsViewController()
        controller.title = "Settings"
        controller.hidesBottomBarWhenPushed = true
        controller.navigationItem.backButtonTitle = " "
        controller.navigationController?.navigationBar.prefersLargeTitles = true
        controller.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createCollectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section{
        case 0:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(168),
                    heightDimension: .absolute(220)
                ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 8, leading: 16, bottom: 4, trailing: 16)
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            return section
        case 1:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(168),
                    heightDimension: .absolute(220)
                ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 4, leading: 16, bottom: 4, trailing: 16)
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            return section
        case 2:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(64)
                ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.contentInsets = .init(top: 4, leading: 16, bottom: 16, trailing: 16)
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            return section
        default:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(64)
                ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            return section
        }
    }
    
    private func headerItem() -> NSCollectionLayoutBoundarySupplementaryItem{
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

//MARK: Extensions
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = viewModel?.getSectionViewModel(at: section)
        switch type {
        case .newRelease(let dataModel):
            return dataModel.count
        case .playlist(let dataModel):
            return dataModel.count
        case .recommended(let dataModel):
            return dataModel.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = viewModel?.getSectionViewModel(at: indexPath.section)
        switch type {
        case .newRelease(let datamodel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as!
                PlaylistsCollectionViewCell
            cell.сonfigure(data: datamodel[indexPath.row])
            
            
            return cell
        case .playlist(let datamodel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as!
                PlaylistsCollectionViewCell
            cell.сonfigure(data: datamodel[indexPath.row])
            
            
            return cell
        case .recommended(let datamodel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedMusicTableViewCell", for: indexPath) as! RecommendedMusicTableViewCell
            cell.сonfigure(data: datamodel[indexPath.row])
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as! CollectionViewHeader
        
        header.configure(with: viewModel?.getHeadersOfSection(with: indexPath.section) ?? "")
        
        return header
    }
}

extension MainViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        let type = viewModel?.getSectionViewModel(at: indexPath.section)
        switch type {
        case .newRelease:
            return "PlaylistsCollectionViewCell"
        case .playlist:
            return "PlaylistsCollectionViewCell"
        case .recommended:
            return "RecommendedMusicTableViewCell"
        default:
            return ""
        }
    }
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = viewModel?.getSectionViewModel(at: section)
        switch type {
        case .newRelease:
            return 3
        case .playlist:
            return 3
        case .recommended:
            return 4
        default:
            return 1
        }
    }
}
