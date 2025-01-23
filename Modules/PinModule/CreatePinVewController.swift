//import UIKit
//
//class CreatePinViewController: UIViewController {
//    private let viewModel: CreatePinViewModel
//    private let mainTitleLabel = UILabel()
//    private let subtitleLabel = UILabel()
//    private let pinDotsStackView = UIStackView()
//    private let skipButton = UIButton()
//    
//    // Массив для хранения точек PIN-кода
//    private var pinDots: [UIView] = []
//    // Скрытое текстовое поле для ввода PIN-кода
//    private let hiddenPinTextField = UITextField()
//    
//    init(viewModel: CreatePinViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupActions()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .black
//        
//        // Настройка заголовка
//        mainTitleLabel.text = "Создайте код приложения"
//        mainTitleLabel.textColor = .white
//        mainTitleLabel.font = .systemFont(ofSize: 28, weight: .bold)
//        view.addSubview(mainTitleLabel)
//        
//        // Настройка подзаголовка
//        subtitleLabel.text = "Введите код из символов"
//        subtitleLabel.textColor = .gray
//        subtitleLabel.font = .systemFont(ofSize: 17)
//        view.addSubview(subtitleLabel)
//        
//        // Настройка стека с точками
//        pinDotsStackView.axis = .horizontal
//        pinDotsStackView.spacing = 20
//        pinDotsStackView.distribution = .fillEqually
//        view.addSubview(pinDotsStackView)
//        
//        // Создаем 4 точки для PIN-кода
//        for _ in 0..<4 {
//            let dotView = UIView()
//            dotView.backgroundColor = .gray
//            dotView.layer.cornerRadius = 8
//            dotView.widthAnchor.constraint(equalToConstant: 16).isActive = true
//            dotView.heightAnchor.constraint(equalToConstant: 16).isActive = true
//            pinDotsStackView.addArrangedSubview(dotView)
//            pinDots.append(dotView)
//        }
//        
//        // Настройка скрытого текстового поля
//        hiddenPinTextField.keyboardType = .numberPad
//        hiddenPinTextField.isHidden = true
//        hiddenPinTextField.delegate = self
//        view.addSubview(hiddenPinTextField)
//        
//        // Настройка кнопки "Пропустить"
//        skipButton.setTitle("Пропустить", for: .normal)
//        skipButton.setTitleColor(.white, for: .normal)
//        skipButton.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 1.0, alpha: 1.0)
//        skipButton.layer.cornerRadius = 25
//        view.addSubview(skipButton)
//        
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        pinDotsStackView.translatesAutoresizingMaskIntoConstraints = false
//        skipButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
//            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            mainTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            subtitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 8),
//            subtitleLabel.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
//            subtitleLabel.trailingAnchor.constraint(equalTo: mainTitleLabel.trailingAnchor),
//            
//            pinDotsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            pinDotsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pinDotsStackView.widthAnchor.constraint(equalToConstant: 200),
//            
//            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            skipButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//    
//    private func setupActions() {
//        // Добавляем tap gesture для показа клавиатуры
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showKeyboard))
//        view.addGestureRecognizer(tapGesture)
//        
//        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
//    }
//    
//    @objc private func showKeyboard() {
//        hiddenPinTextField.becomeFirstResponder()
//    }
//    
//    @objc private func skipButtonTapped() {
//        // Сразу показываем системный алерт при нажатии "Пропустить"
//        showFinalSystemAlert()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        // Показываем клавиатуру автоматически при появлении экрана
//        hiddenPinTextField.becomeFirstResponder()
//    }
//    
//    private func showFinalSystemAlert() {
//        let alert = UIAlertController(
//            title: "Вы успешно вошли в приложение",
//            message: nil,
//            preferredStyle: .alert
//        )
//        
//        let okAction = UIAlertAction(title: "Ок", style: .default)
//        alert.addAction(okAction)
//        
//        present(alert, animated: true)
//    }
//    
//    private func showSuccessAlert() {
//        let alertView = CustomAlertView()
//        alertView.show(in: view) { [weak self] in
//            self?.showFinalSystemAlert()
//        }
//    }
//}
//
//// MARK: - UITextFieldDelegate
//extension CreatePinViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let currentText = textField.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//        
//        // Ограничиваем длину PIN-кода до 4 символов
//        guard updatedText.count <= 4 else { return false }
//        
//        // Обновляем отображение точек
//        for (index, dotView) in pinDots.enumerated() {
//            dotView.backgroundColor = index < updatedText.count ? .white : .gray
//        }
//        
//        // Если введены все 4 цифры
//        if updatedText.count == 4 {
//            // Даем небольшую задержку, чтобы пользователь увидел последнюю точку
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
//                self?.showSuccessAlert()
//            }
//        }
//        
//        return true
//    }
//}


 import UIKit

 class CreatePinViewController: UIViewController {
     private let viewModel: CreatePinViewModel

     // MARK: - Properties
     private var passcode: String = "" {
         didSet {
             updatePasscodeDots()
         }
     }
    
     // MARK: - UI Components
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
         label.text = "Код приложения"
         label.font = .systemFont(ofSize: 24, weight: .medium)
         label.textColor = .white
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
     private let headingLabel: UILabel = {
         let label = UILabel()
         label.text = "Создайте код приложения"
         label.font = .systemFont(ofSize: 32, weight: .bold)
         label.textColor = .white
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
     private let subtitleLabel: UILabel = {
         let label = UILabel()
         label.text = "Введите код из символов"
         label.font = .systemFont(ofSize: 16)
         label.textColor = .white.withAlphaComponent(0.6)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
     private let dotsContainerView: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor(white: 1, alpha: 0.1)
         view.layer.cornerRadius = 24
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
    
     private var dotViews: [UIView] = []
    
     private let skipButton: UIButton = {
         let button = UIButton()
         button.setTitle("Пропустить", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
         button.layer.cornerRadius = 28
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
     private let hiddenTextField: UITextField = {
         let textField = UITextField()
         textField.isHidden = true
         textField.keyboardType = .numberPad
         return textField
     }()
     
     init(viewModel: CreatePinViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
     // MARK: - Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         setupUI()
     }
    
     // MARK: - UI Setup
     private func setupUI() {
         view.backgroundColor = UIColor(red: 0.051, green: 0.043, blue: 0.122, alpha: 1)
        
         setupDotViews()
         setupGradientButton()
        
         view.addSubview(backButton)
         view.addSubview(titleLabel)
         view.addSubview(headingLabel)
         view.addSubview(subtitleLabel)
         view.addSubview(dotsContainerView)
         view.addSubview(skipButton)
         view.addSubview(hiddenTextField)
        
         setupConstraints()
         setupActions()
        
         hiddenTextField.delegate = self
         hiddenTextField.becomeFirstResponder()
     }
    
     private func setupDotViews() {
         // Create 4 dot views
         for _ in 0..<4 {
             let dotView = UIView()
             dotView.backgroundColor = .white.withAlphaComponent(0.3)
             dotView.layer.cornerRadius = 6
             dotView.translatesAutoresizingMaskIntoConstraints = false
             dotViews.append(dotView)
             dotsContainerView.addSubview(dotView)
         }
        
         // Layout dot views
         for (index, dotView) in dotViews.enumerated() {
             NSLayoutConstraint.activate([
                 dotView.centerYAnchor.constraint(equalTo: dotsContainerView.centerYAnchor),
                 dotView.widthAnchor.constraint(equalToConstant: 12),
                 dotView.heightAnchor.constraint(equalToConstant: 12)
             ])
            
             if index == 0 {
                 dotView.leadingAnchor.constraint(equalTo: dotsContainerView.leadingAnchor, constant: 24).isActive = true
             } else {
                 dotView.leadingAnchor.constraint(equalTo: dotViews[index - 1].trailingAnchor, constant: 24).isActive = true
             }
            
             if index == dotViews.count - 1 {
                 dotView.trailingAnchor.constraint(equalTo: dotsContainerView.trailingAnchor, constant: -24).isActive = true
             }
         }
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
         skipButton.layer.masksToBounds = true
         skipButton.layer.insertSublayer(gradientLayer, at: 0)
        
         // We'll update the frame in viewDidLayoutSubviews
         gradientLayer.frame = skipButton.bounds
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
            
             // Heading
             headingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
             headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
             // Subtitle
             subtitleLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 16),
             subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
             // Dots container
             dotsContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
             dotsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             dotsContainerView.heightAnchor.constraint(equalToConstant: 48),
            
             // Skip button
             skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             skipButton.heightAnchor.constraint(equalToConstant: 56),
             skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
         ])
     }
    
     private func setupActions() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showKeyboard))
         view.addGestureRecognizer(tapGesture)
         backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
         skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
     }
    
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         if let gradientLayer = skipButton.layer.sublayers?.first as? CAGradientLayer {
             gradientLayer.frame = skipButton.bounds
         }
     }
    
     private func updatePasscodeDots() {
         for (index, dotView) in dotViews.enumerated() {
             dotView.backgroundColor = index < passcode.count ? .white : .white.withAlphaComponent(0.3)
         }
     }
    
     // MARK: - Actions
     
     @objc private func showKeyboard() {
         hiddenTextField.becomeFirstResponder()
     }
     
     @objc private func backButtonTapped() {
         navigationController?.popViewController(animated: true)
     }
    
     @objc private func skipButtonTapped() {
         showFinalSystemAlert()
     }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         // Показываем клавиатуру автоматически при появлении экрана
         hiddenTextField.becomeFirstResponder()
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
         let newText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
         // Ensure only numbers and maximum 4 digits
         if newText.count <= 4, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
             passcode = newText
            
             // Check if passcode is complete
             if newText.count == 4 {
                 // Handle complete passcode
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                     self.handleCompletePasscode()
                     self.showSuccessAlert()
                 }
             }
             return true
         }
         return false
     }
    
     private func handleCompletePasscode() {
         // Handle complete passcode entry
         print("Passcode entered: \(passcode)")
     }
 }
