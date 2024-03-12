//
//  CollectionViewHeader.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 05.03.2024.
//

import UIKit

final class CollectionViewHeader: UICollectionReusableView {
    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    func configure(with title: String){
        self.title.text = title
    }
}
