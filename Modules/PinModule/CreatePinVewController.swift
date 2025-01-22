import UIKit

class CreatePinViewController: UIViewController {
    private let viewModel: CreatePinViewModel
    private let mainTitleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let pinTextField = UITextField()
    private let skipButton = UIButton()
    
    init(viewModel: CreatePinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CreatePinViewController viewDidLoad called")
        setupUI()
        setupActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("CreatePinViewController viewWillAppear called")
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        title = viewModel.getScreenTitle()
        
        // Main Title
        mainTitleLabel.text = viewModel.getMainTitle()
        mainTitleLabel.textColor = .white
        mainTitleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        mainTitleLabel.textAlignment = .left
        view.addSubview(mainTitleLabel)
        
        // Subtitle
        subtitleLabel.text = viewModel.getSubtitle()
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .systemFont(ofSize: 17)
        subtitleLabel.textAlignment = .left
        view.addSubview(subtitleLabel)
        
        // PIN TextField
        pinTextField.isSecureTextEntry = true
        pinTextField.keyboardType = .numberPad
        pinTextField.textColor = .white
        pinTextField.tintColor = .white
        pinTextField.textAlignment = .center
        pinTextField.font = .systemFont(ofSize: 24)
        view.addSubview(pinTextField)
        
        // Skip Button
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
        pinTextField.translatesAutoresizingMaskIntoConstraints = false
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: mainTitleLabel.trailingAnchor),
            
            pinTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pinTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            pinTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            pinTextField.heightAnchor.constraint(equalToConstant: 50),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    @objc private func skipButtonTapped() {
        // Добавим позже обработку нажатия
    }
}
