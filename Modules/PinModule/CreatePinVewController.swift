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
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Создайте код приложения"
        label.font = .systemFont(ofSize: 24, weight: .bold)
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
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
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
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            backButton.heightAnchor.constraint(equalToConstant: 22),
           
            // Title
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            // Heading
            headingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 75),
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 47),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            // Dots container
            dotsContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 36),
            dotsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dotsContainerView.heightAnchor.constraint(equalToConstant: 52),
           
            // Skip button
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            skipButton.heightAnchor.constraint(equalToConstant: 50),
            skipButton.topAnchor.constraint(equalTo: dotsContainerView.bottomAnchor, constant: 77)
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
                // Скрываем клавиатуру
                textField.resignFirstResponder()
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
