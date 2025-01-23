//
//  SupportViewController.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 23.1.25..
//

import UIKit

class SupportViewController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        button.setImage(UIImage(systemName: "arrow.left", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Не пришел код?"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

        private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обратитесь в чат\nподдержки"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

        private let supportButton: UIButton = {
        let button = UIButton()
        button.setTitle("Написать в поддержку", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel: SupportViewModel
    var onBackButtonTapped: (() -> Void)?
    
    init(viewModel: SupportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.051, green: 0.043, blue: 0.122, alpha: 1)
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(supportButton)
        
        setupGradientButton()
        setupConstraints()
        setupActions()
    }
    
    private func setupGradientButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.294, green: 0.431, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.733, green: 0.294, blue: 1, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 28
        supportButton.layer.masksToBounds = true
        supportButton.layer.insertSublayer(gradientLayer, at: 0)
        
        // We'll update the frame in viewDidLayoutSubviews
        gradientLayer.frame = supportButton.bounds
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Subtitle
            subtitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Support button
            supportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            supportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            supportButton.heightAnchor.constraint(equalToConstant: 56),
            supportButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        supportButton.addTarget(self, action: #selector(supportButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradientLayer = supportButton.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = supportButton.bounds
        }
    }

     @objc private func backButtonTapped() {
        onBackButtonTapped?()
    }
    
    @objc private func supportButtonTapped() {
        // Handle support button tap
    }
}
