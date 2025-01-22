//
//  SMSCodeViewController.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class SMSCodeViewController: UIViewController {
    private let viewModel: SMSCodeViewModel
    var onCodeVerified: (() -> Void)?

    private let codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите код"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        return textField
    }()

    private let verifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подтвердить", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    init(viewModel: SMSCodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        view.backgroundColor = .white
        title = "Введите SMS-код"

        view.addSubview(codeTextField)
        view.addSubview(verifyButton)

        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        verifyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            codeTextField.widthAnchor.constraint(equalToConstant: 200),
            
            verifyButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 20),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyButton.widthAnchor.constraint(equalToConstant: 200),
            verifyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupActions() {
        verifyButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    @objc private func continueButtonTapped() {
        print("Continue button tapped in SMSCodeViewController")
        guard let code = codeTextField.text, !code.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите код")
            return
        }
        
        if viewModel.isCodeValid(code) {
            print("SMS code is valid, calling onCodeVerified")
            onCodeVerified?()
        } else {
            print("Invalid SMS code")
            showAlert(title: "Ошибка", message: "Неверный код")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
