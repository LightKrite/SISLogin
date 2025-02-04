//
//  SMSCodeViewController.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import UIKit

class SMSCodeViewController: UIViewController {
    
    private let viewModel: SMSCodeViewModel
    private var otpStackView: UIStackView!
    private var otpTextFields: [UITextField] = []
    private var timer: Timer?
    private var timeRemaining: Int = 300 // 5 minutes in seconds
    var onCodeVerified: (() -> Void)?
    var onNoCodeTapped: (() -> Void)?

    
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
        label.text = PhoneInputViewModel().getScreenTitle()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verificationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Верификация"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код из смс,\nчто мы отправили вам"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Запросить код можно\nчерез 05:00"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(PhoneInputViewModel().getScreenTitle(), for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.layer.cornerRadius = 28
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Я не получил код!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Добавляем свойство для хранения ссылки на градиент
    private var gradientLayer: CAGradientLayer?

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
        startTimer()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = registerButton.bounds
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.051, green: 0.043, blue: 0.122, alpha: 1)
        
        setupOTPStackView()
        setupGradientButton() // Добавляем настройку градиента
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(verificationTitleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(timerLabel)
        view.addSubview(otpStackView)
        view.addSubview(registerButton)
        view.addSubview(noCodeButton)
        
        setupConstraints()
        setupActions()
    }
    
    private func setupOTPStackView() {
        otpStackView = UIStackView()
        otpStackView.axis = .horizontal
        otpStackView.spacing = 8
        otpStackView.distribution = .fillEqually
        otpStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create 6 text fields for OTP
        for i in 0..<6 {
            let textField = createOTPTextField()
            textField.tag = i
            textField.delegate = self
            otpStackView.addArrangedSubview(textField)
            otpTextFields.append(textField)
        }
    }
    
    private func createOTPTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 24, weight: .bold)
        textField.keyboardType = .numberPad
        textField.delegate = self
        
        // Add border
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.294, green: 0.431, blue: 1, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        
        // Set size constraints
        textField.heightAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        
        return textField
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back button
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            
            // Title
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Verification title
            verificationTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 66),
            verificationTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: verificationTitleLabel.bottomAnchor, constant: 18),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Timer label
            timerLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 35),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // OTP Stack View
            otpStackView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40),
            otpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            otpStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            otpStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            otpStackView.heightAnchor.constraint(equalToConstant: 46),
            
            // Register button
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.topAnchor.constraint(equalTo: otpStackView.bottomAnchor, constant: 28),
            
            // No code button
            noCodeButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 32),
            noCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        noCodeButton.addTarget(self, action: #selector(noCodeButtonTapped), for: .touchUpInside)
    }

    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                   target: self,
                                   selector: #selector(updateTimer),
                                   userInfo: nil,
                                   repeats: true)
    }
    
    @objc private func updateTimer() {
        timeRemaining -= 1
        if timeRemaining >= 0 {
            let minutes = timeRemaining / 60
            let seconds = timeRemaining % 60
            timerLabel.text = "Запросить код можно\nчерез \(String(format: "%02d:%02d", minutes, seconds))"
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func noCodeButtonTapped() {
        onNoCodeTapped?()
    }

    @objc private func registerButtonTapped() {
        print("Continue button tapped in SMSCodeViewController")
        let code = otpTextFields.compactMap { $0.text }.joined()
        
        guard !code.isEmpty, code.count == 6 else {
            showAlert(title: "Ошибка", message: "Введите код полностью")
            clearOTPFields()
            return
        }
        
        if viewModel.validateCode(code) {
            print("SMS code is valid, calling onCodeVerified")
            onCodeVerified?()
        } else {
            print("Invalid SMS code")
            showAlert(title: "Ошибка", message: "Неверный код")
            clearOTPFields()
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func clearOTPFields() {
        otpTextFields.forEach { $0.text = "" }
        otpTextFields.first?.becomeFirstResponder()
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
        registerButton.layer.masksToBounds = true
        registerButton.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.isHidden = true // Изначально градиент скрыт
        
        // Сохраняем ссылку на градиент для последующего использования
        self.gradientLayer = gradientLayer
    }

    private func validateOTP() {
        let otp = otpTextFields.compactMap { $0.text }.joined()
        if otp.count == 6 {
            // Скрываем клавиатуру
            view.endEditing(true)
            // Показываем градиент на кнопке
            gradientLayer?.isHidden = false
            registerButton.backgroundColor = .clear
            // Handle complete OTP
            print("Complete OTP: \(otp)")
        } else {
            // Скрываем градиент если код неполный
            gradientLayer?.isHidden = true
            registerButton.backgroundColor = UIColor(white: 1, alpha: 0.2)
        }
    }
}

extension SMSCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        // Проверяем, что пользователь нажал backspace
        if string.isEmpty {
            // 1. Если текущее поле НЕ пустое, стираем символ и переходим к предыдущему
            if let currentText = textField.text, !currentText.isEmpty {
                textField.text = ""
                // Переходим к предыдущему полю, если оно есть
                let prevIndex = textField.tag - 1
                if prevIndex >= 0 {
                    otpTextFields[prevIndex].becomeFirstResponder()
                }
            } else {
                // 2. Если текущее поле уже пустое, стираем символ в предыдущем поле и уходим в него
                let prevIndex = textField.tag - 1
                if prevIndex >= 0 {
                    let prevTextField = otpTextFields[prevIndex]
                    prevTextField.text = ""
                    prevTextField.becomeFirstResponder()
                }
            }
            // Возвращаем false, т.к. мы уже обработали backspace вручную
            return false
        }
        
        // ======== Обычный ввод символов (не backspace) ========

        // Ограничиваем ввод максимум одним символом за раз
        guard string.count <= 1 else { return false }

        if let text = textField.text,
           let textRange = Range(range, in: text) {

            let updatedText = text.replacingCharacters(in: textRange, with: string)

            // Разрешаем вводить только 1 символ
            if updatedText.count <= 1 {
                // Устанавливаем текст вручную
                textField.text = updatedText

                // Если пользователь ввёл символ, переходим к следующему полю
                if updatedText.count == 1 {
                    if textField.tag < otpTextFields.count - 1 {
                        otpTextFields[textField.tag + 1].becomeFirstResponder()
                    } else {
                        // Если это последнее поле, убираем фокус
                        textField.resignFirstResponder()
                        // И запускаем валидацию кода
                        validateOTP()
                    }
                }
            }
        }
        // Возвращаем false, чтобы UITextField не обрабатывал ввод повторно
        return false
    }
}
