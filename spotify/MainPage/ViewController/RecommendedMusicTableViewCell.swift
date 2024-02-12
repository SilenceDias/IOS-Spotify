//
//  RecommendedMusicTableViewCell.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 10.02.2024.
//

import UIKit
import SnapKit

class RecommendedMusicTableViewCell: UITableViewCell {
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
        return image
    }()
    
    private var titlesStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = Constraints.titleStackSpacing
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let rightView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "icon_right")
        return image
    }()
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configure(data: RecommendedMusicDataModel?){
        guard let data else {return}
        self.musicImage.image = data.image
        self.title.text = data.title
        if let subTitle = data.subTitle {
            self.subTitle.text = subTitle
        }
        else {
            subTitle.isHidden = true
        }
    }
    
    private func setupViews() {
        contentView.backgroundColor = .black
        selectionStyle = .none
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
            make.top.bottom.equalTo(musicImage)
        }
        rightView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constraints.rightViewSize)
        }
    }
}
