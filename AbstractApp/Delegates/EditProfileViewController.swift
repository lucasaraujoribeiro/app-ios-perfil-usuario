import UIKit

protocol EditProfileDelegate: AnyObject {
    func didUpdateProfile(_ user: User)
}

class EditProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: EditProfileDelegate?
    private var user: User
    
    // MARK: - Initialization
    init(user: User) {
        self.user = user
        super.init(nibName: "EditProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUserData()
    }
    
    private func setupUI() {
        title = "Editar Perfil"
        
        // Configurar botão de salvar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Salvar",
            style: .done,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        // Configurar botão de cancelar
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancelar",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
    }
    
    private func loadUserData() {
        nameTextField.text = user.name
        emailTextField.text = user.email
        phoneTextField.text = user.phone
        addressTextField.text = user.address
        birthDateTextField.text = user.birthDate
    }
    
    // MARK: - Actions
    @objc private func saveButtonTapped() {
        // Validar campos
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty,
              let address = addressTextField.text, !address.isEmpty,
              let birthDate = birthDateTextField.text, !birthDate.isEmpty else {
            showAlert(message: "Por favor, preencha todos os campos")
            return
        }
        
        // Atualizar usuário
        let updatedUser = User(
            name: name,
            email: email,
            phone: phone,
            address: address,
            birthDate: birthDate
        )
        
        // Salvar no banco de dados
        StoreManager.shared.save(updatedUser, forKey: "userProfile")
        
        // Notificar delegate
        delegate?.didUpdateProfile(updatedUser)
        
        // Fechar tela
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Atenção",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
} 
