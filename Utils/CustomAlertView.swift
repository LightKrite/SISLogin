//
//  CustomAlertView.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 22.1.25..
//
import UIKit

class CustomAlertView: UIView {
    private let containerView = UIView()
    private let successLabel = UILabel()
    private let enterButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Настройка контейнера
        containerView.backgroundColor = UIColor(white: 0.15, alpha: 1.0) // Темно-серый цвет
        containerView.layer.cornerRadius = 16
        addSubview(containerView)
        
        // Настройка текста успеха
        successLabel.text = "Вы успешно создали код приложения"
        successLabel.textColor = .white
        successLabel.textAlignment = .center
        successLabel.numberOfLines = 0
        successLabel.font = .systemFont(ofSize: 17)
        containerView.addSubview(successLabel)
        
        // Настройка кнопки входа
        enterButton.setTitle("Войти в приложение", for: .normal)
        enterButton.setTitleColor(.systemBlue, for: .normal)
        enterButton.backgroundColor = UIColor(white: 0.2, alpha: 1.0) // Чуть светлее фона
        enterButton.layer.cornerRadius = 12
        containerView.addSubview(enterButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            successLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            successLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            successLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            enterButton.topAnchor.constraint(equalTo: successLabel.bottomAnchor, constant: 24),
            enterButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            enterButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            enterButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            enterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func show(in view: UIView, completion: @escaping () -> Void) {
        frame = view.bounds
        alpha = 0
        view.addSubview(self)
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        self.completion = completion
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    private var completion: (() -> Void)?
    
    @objc private func enterButtonTapped() {
        hideAndComplete()
    }
    
    private func hideAndComplete() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.completion?()
        }
    }
}
