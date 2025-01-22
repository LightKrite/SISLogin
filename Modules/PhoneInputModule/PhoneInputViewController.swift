import UIKit

class PhoneInputViewController: UIViewController {
    private let viewModel: PhoneInputViewModel

    var onCodeRequested: (() -> Void)?
    var onPhoneNumberSubmitted: (() -> Void)?

    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+7 (___) ___-__-__"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        return textField
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
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
        view.backgroundColor = .white
        title = viewModel.getScreenTitle()
        setupUI()
        setupActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("PhoneInputViewController viewWillAppear called")
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = viewModel.getScreenTitle()

        view.addSubview(phoneTextField)
        view.addSubview(continueButton)

        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            phoneTextField.widthAnchor.constraint(equalToConstant: 250),
            
            continueButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 200),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupActions() {
        print("Setting up continue button action")
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    @objc private func continueButtonTapped() {
        print("Continue button tapped")
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            print("Phone number is empty")
            showAlert(title: "Ошибка", message: "Введите номер телефона")
            return
        }
        
        if viewModel.isPhoneNumberValid(phoneNumber) {
            print("Phone number is valid, calling onPhoneNumberSubmitted")
            onPhoneNumberSubmitted?()
        } else {
            print("Phone number is invalid")
            showAlert(title: "Ошибка", message: "Введите корректный номер телефона")
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
