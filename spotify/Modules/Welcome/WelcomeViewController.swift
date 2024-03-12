//
//  WelcomeViewController.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 17.02.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.green, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGreen
        self.title = "Spotify"
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    @objc
    private func didTapLogin() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            self?.handleSignIn(status: success)
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(status: Bool){
        guard status else {
            let alert = UIAlertController(title: "Oops", message: "Smth went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let tabbarController = TabBarViewController()
        tabbarController.modalPresentationStyle = .fullScreen
        present(tabbarController, animated: true)
    }
}
