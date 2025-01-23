import UIKit

class PhoneInputViewController: UIViewController {
    private let viewModel: PhoneInputViewModel
    
    var onCodeRequested: (() -> Void)?
    var onPhoneNumberSubmitted: (() -> Void)?
    
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
    
        private let phoneLabel: UILabel = {
            let label = UILabel()
            label.text = "Номер телефона"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let countryCodeButton: UIButton = {
        let button = UIButton()

        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = UIColor(white: 1, alpha: 0.1) // Прозрачный фон
        config.baseForegroundColor = .white // Цвет текста и иконки
        config.image = UIImage(systemName: "chevron.down") // Иконка справа
        config.title = "+7" // Текст кнопки
        config.imagePadding = 8 // Отступ между текстом и иконкой
        config.imagePlacement = .trailing // Иконка справа от текста

        button.configuration = config
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = .white
        textField.keyboardType = .numberPad
        
        // Установка цвета для placeholder
        let placeholderText = "(___) ___-__-__"
        let placeholderColor = UIColor(white: 1, alpha: 0.7) // Задайте нужный цвет
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [.foregroundColor: placeholderColor]
        )
        
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Код придет на ваш номер телефона"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let getCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить код", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: PhoneInputViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        print("PhoneInputViewController initialized")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PhoneInputViewController viewDidLoad called")
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("PhoneInputViewController viewWillAppear called")
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.051, green: 0.043, blue: 0.122, alpha: 1)
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(phoneLabel)
        view.addSubview(countryCodeButton)
        view.addSubview(phoneTextField)
        view.addSubview(infoLabel)
        view.addSubview(getCodeButton)
        
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
        getCodeButton.layer.masksToBounds = true
        getCodeButton.layer.insertSublayer(gradientLayer, at: 0)
        
        // We'll update the frame in viewDidLayoutSubviews
        gradientLayer.frame = getCodeButton.bounds
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Title
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Phone label
            phoneLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Country code button
            countryCodeButton.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            countryCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            countryCodeButton.widthAnchor.constraint(equalToConstant: 80),
            countryCodeButton.heightAnchor.constraint(equalToConstant: 48),
            
            // Phone text field
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: countryCodeButton.trailingAnchor, constant: 8),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 48),
            
            // Info label
            infoLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Get code button
            getCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            getCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            getCodeButton.heightAnchor.constraint(equalToConstant: 56),
            getCodeButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 32)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        countryCodeButton.addTarget(self, action: #selector(countryCodeButtonTapped), for: .touchUpInside)
        getCodeButton.addTarget(self, action: #selector(getCodeButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradientLayer = getCodeButton.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = getCodeButton.bounds
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func countryCodeButtonTapped() {
        // Handle country code selection
    }
    
    @objc private func getCodeButtonTapped() {
        print("Get code button tapped")
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            print("Phone number is empty")
            showAlert(title: "Ошибка", message: "Введите номер телефона")
            phoneTextField.text = "" // Очищаем поле при пустом номере
            return
        }
        
        if viewModel.isPhoneNumberValid(phoneNumber) {
            print("Phone number is valid, calling onPhoneNumberSubmitted")
            onPhoneNumberSubmitted?()
        } else {
            print("Phone number is invalid")
            showAlert(title: "Ошибка", message: "Введите корректный номер телефона")
            phoneTextField.text = "" // Очищаем поле при невалидном номере
        }
    }
    
    @objc private func submitButtonTapped() {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            // Показать ошибку если номер пустой
            return
        }
        
        // Вызываем замыкающий блок при успешной валидации
        onPhoneNumberSubmitted?()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
