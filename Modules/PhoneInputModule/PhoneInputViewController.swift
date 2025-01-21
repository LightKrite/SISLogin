import UIKit

class PhoneInputViewController: UIViewController {
    private let viewModel: PhoneInputViewModel

    var onCodeRequested: (() -> Void)?

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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PhoneInputViewController loaded")
        view.backgroundColor = .white
        title = viewModel.getScreenTitle()
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
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    @objc private func continueButtonTapped() {
        guard let phoneNumber = phoneTextField.text else { return }

        if viewModel.isPhoneNumberValid(phoneNumber) {
            onCodeRequested?()
        } else {
            showAlert(title: "Ошибка", message: "Введите корректный номер телефона")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
