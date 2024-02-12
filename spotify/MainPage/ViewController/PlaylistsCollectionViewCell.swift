//
//  PlaylistsCollectionViewCell.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 12.02.2024.
//

import UIKit

class PlaylistsCollectionViewCell: UICollectionViewCell {
    
    //MARK: UI Components
    private var playlistImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var nameOfPlaylistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configure(data: AlbumsDataModel?){
        guard let data else {return}
        self.nameOfPlaylistLabel.text = data.title
        self.playlistImage.image = data.image
    }
    
    private func setupViews(){
        [playlistImage, nameOfPlaylistLabel].forEach {
            contentView.addSubview($0)
        }
        
        playlistImage.snp.makeConstraints { make in
            make.size.equalTo(152)
            make.top.left.right.equalToSuperview().inset(8)
        }
        nameOfPlaylistLabel.snp.makeConstraints { make in
            make.top.equalTo(playlistImage.snp.bottom).offset(8)
            make.left.bottom.right.equalToSuperview().inset(8)
        }
    }
}
