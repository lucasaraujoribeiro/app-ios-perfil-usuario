import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    
    // MARK: - Properties
    private var user: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Configurar imagem do usuário
        userImage.layer.cornerRadius = self.userImage.frame.size.height / 2
        userImage.layer.masksToBounds = true
        
        // Configurar botão de edição
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Editar",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
    }
    
    private func loadUserData() {
        // Carregar dados do usuário do banco de dados
        if let savedUser: User = StoreManager.shared.get(forKey: "userProfile") {
            user = savedUser
        } else {
            // Se não houver dados salvos, criar usuário padrão
            user = User.getDefaultUser()
            // Salvar usuário padrão no banco de dados
            if let defaultUser = user {
                StoreManager.shared.save(defaultUser, forKey: "userProfile")
            }
        }
        
        // Atualizar UI com os dados do usuário
        updateUI()
    }
    
    private func updateUI() {
        guard let user = user else { return }
        
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        addressLabel.text = user.address
        birthDateLabel.text = user.birthDate
    }
    
    // MARK: - Actions
    @objc private func editButtonTapped() {
        guard let user = user else { return }
        
        let editVC = EditProfileViewController(user: user)
        editVC.delegate = self
        let navController = UINavigationController(rootViewController: editVC)
        present(navController, animated: true)
    }
    
    @IBAction func handleLogoff(_ sender: Any) {
        StoreManager.shared.remove(forKey: "logged")
        self.dismiss(animated: true)
    }
}

// MARK: - EditProfileDelegate
extension ProfileViewController: EditProfileDelegate {
    func didUpdateProfile(_ user: User) {
        self.user = user
        updateUI()
    }
}
