//
//  ProfileViewController.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 03.03.2024.
//

import UIKit
import Kingfisher
import SkeletonView

class ProfileViewController: BaseViewController {
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 150
        image.contentMode = .scaleAspectFill
        image.isSkeletonable = true
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private var countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private var subscriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        loadData()
        setupViews()
        
    }
    
    private func setupViews() {
        title = "Profile"
        [image, nameLabel, emailLabel, countryLabel, subscriptionLabel].forEach {
            view.addSubview($0)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(300)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
        }
        
        subscriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(countryLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
        }
        
        image.showAnimatedGradientSkeleton()
    }
    
    private func loadData(){
        ProfileManager.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                self?.nameLabel.text = "Name: " + result.displayName
                self?.emailLabel.text = "Email: " + result.email
//                self?.countryLabel.text = "Country: " + result.country
//                self?.subscriptionLabel.text = "Subscription: " + result.product
                let url = URL(string: result.images.first?.url ?? "")
                if url?.absoluteString == "" {
                    self?.image.image = UIImage(named: "noPfp")
                }
                else {
                    self?.image.kf.setImage(with: url)
                }
                self?.image.hideSkeleton()
            }
        }
    }
}
