//
//  AuthViewController.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 17.02.2024.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    //MARK: - Prop
    public var completionHandler: ((Bool) -> Void)?
    
    private var viewModel: AuthViewModel?
    
    //MARK: - UI
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
        handleWebUrl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    private func setupViewModel() {
        viewModel = AuthViewModel()
    }
    
    private func setupViews() {
        self.title = "Sign In"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    private func handleWebUrl() {
        guard let url = AuthManager.shared.signInUrl else {return}
        webView.load(URLRequest(url: url))
    }
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        let components = URLComponents(string: url.absoluteString)
        
        guard let code = components?.queryItems?.first(where: {$0.name == "code"})?.value else { return }
        
        webView.isHidden = true
        
        viewModel?.exchangeCodeForToken(code: code, completion: { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
                self?.completionHandler?(success)
            }
        })
    }
}
