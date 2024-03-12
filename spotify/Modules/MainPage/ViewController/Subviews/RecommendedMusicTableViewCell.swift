//
//  RecommendedMusicTableViewCell.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 10.02.2024.
//

import UIKit
import SnapKit
import SkeletonView

class RecommendedMusicTableViewCell: UICollectionViewCell {
    //MARK: Properties
    private enum Constraints {
        static let imageSize: CGFloat = 48
        static let imageCornerRadius: CGFloat = 24
        static let titleStackSpacing: CGFloat = 2
        static let rightViewSize: CGFloat = 24
    }
    
    //MARK: UI Components
    private var musicImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Constraints.imageCornerRadius
        image.contentMode = .scaleAspectFill
        image.isSkeletonable = true
        return image
    }()
    
    private var titlesStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = Constraints.titleStackSpacing
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.alignment = .fill
        stack.isSkeletonable = true
        return stack
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.isSkeletonable = true
        return label
    }()
    
    private var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .white
        label.isSkeletonable = true
        return label
    }()
    
    private let rightView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "icon_right")
        return image
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func сonfigure(data: RecommendedMusicDataModel?){
        guard let data else {return}
        self.title.text = data.title
        if let subTitle = data.subTitle {
            self.subTitle.text = subTitle
        }
        else {
            subTitle.isHidden = true
        }
        let url = URL(string: data.imageURL)
        self.musicImage.kf.setImage(with: url)
        self.musicImage.layer.cornerRadius = Constraints.imageCornerRadius
    }
    
    private func setupViews() {
        isSkeletonable = true
        contentView.backgroundColor = .black
        [title, subTitle].forEach {
            titlesStackView.addArrangedSubview($0)
        }
        [musicImage, titlesStackView, rightView].forEach {
            contentView.addSubview($0)
        }
        musicImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
            make.size.equalTo(Constraints.imageSize)
        }
        titlesStackView.snp.makeConstraints { make in
            make.left.equalTo(musicImage.snp.right).offset(12)
            make.right.equalToSuperview().inset(36)
            make.top.bottom.equalTo(musicImage)
        }
        rightView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constraints.rightViewSize)
        }
    }
    
    func startSkeleton(){
        self.showAnimatedGradientSkeleton()
    }
    
    func stopSkeletion(){
        self.hideSkeleton()
    }
}
