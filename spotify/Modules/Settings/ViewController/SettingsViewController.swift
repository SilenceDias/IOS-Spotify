//
//  SettingsViewController.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 03.03.2024.
//

import UIKit
import SwiftKeychainWrapper

class SettingsViewController: BaseViewController {
    
    private var sections = [Section]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
    }
    
    private func setupViews() {
        title = "Settings"
        view.backgroundColor = .black
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupData() {
        sections.append(
            .init(
                title: "Profile",
                rows: [.init(title: "View Your Profile",
                             handler: { [weak self] in
                                 DispatchQueue.main.async {
                                     self?.showProfilePage()
                                 }
                             }
                            )
                ]
            )
        )
        
        sections.append(
            .init(
                title: "Account",
                rows: [.init(title: "Log Out",
                             handler: { [weak self] in
                                 DispatchQueue.main.async {
                                     self?.didTapSignOut()
                                 }
                             }
                            )
                ]
            )
        )
        
    }
    
    private func showProfilePage(){
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapSignOut(){
        KeychainWrapper.standard.removeAllKeys()
        let welcomeController = WelcomeViewController()
        let navigationController = UINavigationController(rootViewController: welcomeController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let model = sections[indexPath.section].rows[indexPath.row]
        
        cell.textLabel?.text = model.title
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].rows[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let modelTitle = sections[section].title
        return modelTitle
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .lightGray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.textAlignment = .left
    }
}
