import UIKit

class CreatePinViewController: UIViewController {
    private let viewModel: CreatePinViewModel
    private let mainTitleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let pinDotsStackView = UIStackView()
    private let skipButton = UIButton()
    
    // Массив для хранения точек PIN-кода
    private var pinDots: [UIView] = []
    // Скрытое текстовое поле для ввода PIN-кода
    private let hiddenPinTextField = UITextField()
    
    init(viewModel: CreatePinViewModel) {
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
        view.backgroundColor = .black
        
        // Настройка заголовка
        mainTitleLabel.text = "Создайте код приложения"
        mainTitleLabel.textColor = .white
        mainTitleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        view.addSubview(mainTitleLabel)
        
        // Настройка подзаголовка
        subtitleLabel.text = "Введите код из символов"
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .systemFont(ofSize: 17)
        view.addSubview(subtitleLabel)
        
        // Настройка стека с точками
        pinDotsStackView.axis = .horizontal
        pinDotsStackView.spacing = 20
        pinDotsStackView.distribution = .fillEqually
        view.addSubview(pinDotsStackView)
        
        // Создаем 4 точки для PIN-кода
        for _ in 0..<4 {
            let dotView = UIView()
            dotView.backgroundColor = .gray
            dotView.layer.cornerRadius = 8
            dotView.widthAnchor.constraint(equalToConstant: 16).isActive = true
            dotView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            pinDotsStackView.addArrangedSubview(dotView)
            pinDots.append(dotView)
        }
        
        // Настройка скрытого текстового поля
        hiddenPinTextField.keyboardType = .numberPad
        hiddenPinTextField.isHidden = true
        hiddenPinTextField.delegate = self
        view.addSubview(hiddenPinTextField)
        
        // Настройка кнопки "Пропустить"
        skipButton.setTitle("Пропустить", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 1.0, alpha: 1.0)
        skipButton.layer.cornerRadius = 25
        view.addSubview(skipButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        pinDotsStackView.translatesAutoresizingMaskIntoConstraints = false
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: mainTitleLabel.trailingAnchor),
            
            pinDotsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pinDotsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinDotsStackView.widthAnchor.constraint(equalToConstant: 200),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        // Добавляем tap gesture для показа клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    @objc private func showKeyboard() {
        hiddenPinTextField.becomeFirstResponder()
    }
    
    @objc private func skipButtonTapped() {
        // Сразу показываем системный алерт при нажатии "Пропустить"
        showFinalSystemAlert()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Показываем клавиатуру автоматически при появлении экрана
        hiddenPinTextField.becomeFirstResponder()
    }
    
    private func showFinalSystemAlert() {
        let alert = UIAlertController(
            title: "Вы успешно вошли в приложение",
            message: nil,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func showSuccessAlert() {
        let alertView = CustomAlertView()
        alertView.show(in: view) { [weak self] in
            self?.showFinalSystemAlert()
        }
    }
}

// MARK: - UITextFieldDelegate
extension CreatePinViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Ограничиваем длину PIN-кода до 4 символов
        guard updatedText.count <= 4 else { return false }
        
        // Обновляем отображение точек
        for (index, dotView) in pinDots.enumerated() {
            dotView.backgroundColor = index < updatedText.count ? .white : .gray
        }
        
        // Если введены все 4 цифры
        if updatedText.count == 4 {
            // Даем небольшую задержку, чтобы пользователь увидел последнюю точку
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.showSuccessAlert()
            }
        }
        
        return true
    }
}