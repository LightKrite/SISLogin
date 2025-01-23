//
//  StartViewController.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class StartViewController: UIViewController {
    private let viewModel: StartViewModel
    
    var onLoginRequested: (() -> Void)?
    var onRegistrationRequested: (() -> Void)?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SIS"
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери свою безопасность"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white.withAlphaComponent(0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти по номеру телефона", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас нет аккаунта?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться сейчас", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 0.294, green: 0.431, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        print("StartViewController initialized") // Отладочный вывод
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        // Background setup
        view.backgroundColor = UIColor(red: 0.051, green: 0.043, blue: 0.122, alpha: 1)
        
        // Add subviews
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginButton)
        view.addSubview(noAccountLabel)
        view.addSubview(registerButton)
        
        // Setup gradient background for login button
        setupLoginButtonGradient()
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Logo constraints
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Title constraints
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            
            // Subtitle constraints
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            // Login button constraints
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 48),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            
            // No account label constraints
            noAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noAccountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
            
            // Register button constraints
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: noAccountLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupLoginButtonGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.294, green: 0.431, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.733, green: 0.294, blue: 1, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        // We need to set the frame in viewDidLayoutSubviews
        loginButton.layer.masksToBounds = true
        loginButton.layer.insertSublayer(gradientLayer, at: 0)
        
        // Add this property to update gradient frame when view layout changes
        gradientLayer.frame = loginButton.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update gradient frame
        if let gradientLayer = loginButton.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = loginButton.bounds
        }
    }
    
    private func setupActions() {
        print("Setting up button actions") // Отладочный вывод
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        print("Login button tapped")
        onLoginRequested?()
    }
    
    @objc private func registerTapped() {
        print("Register button tapped")
        onRegistrationRequested?()
    }
}


