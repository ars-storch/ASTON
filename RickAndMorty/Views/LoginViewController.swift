//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 13.10.2022.
//
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    var viewModel = LoginViewModel()

    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let attentionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.statusText.bind { statusText in
            DispatchQueue.main.async {
                self.attentionLabel.text = statusText
            }
        }
        
        viewModel.statusColor.bind { statusColor in
            DispatchQueue.main.async {
                self.attentionLabel.textColor = statusColor
            }
        }
    }
    
    func performTransition() {
        let viewModel: CharacterListViewModel = CharacterListDefaultViewModel(networkService: DefaultNetworkService())
        let charVC = CharachtersViewController(viewModel: viewModel)
        charVC.title = "Characters"
        let navigationController = UINavigationController(rootViewController: charVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    private func layout() {
        view.backgroundColor = .white
        
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(150)
        }

        loginTextField.placeholder = "Enter login"
        view.addSubview(loginTextField)
        
        loginTextField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(welcomeLabel).inset(100)
        }
        
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(loginTextField).inset(40)
        }
        
        let loginButton = UIButton()
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = .blue
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.textColor = .white
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(150)
            maker.top.equalTo(passwordTextField).inset(60)
        }
        
        attentionLabel.translatesAutoresizingMaskIntoConstraints = false
        attentionLabel.numberOfLines = 0
        attentionLabel.textAlignment = .center
        view.addSubview(attentionLabel)
        
        attentionLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(welcomeLabel.snp.top).inset(-20)
        }
    }
    
    @objc func login() {
        viewModel.loginButtonPressed(login: loginTextField.text ?? "No value", password: passwordTextField.text ?? "No value")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if self?.viewModel.isLoggedIn == true {
                self?.performTransition()
            }
        }

    }

}
