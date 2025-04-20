

import Foundation

public final class StoreManager {
    
    // MARK: - Singleton Instance
    public static let shared = StoreManager()
    
    private var defaults: UserDefaults
    
    private init() {
        defaults = UserDefaults.standard
    } // Impede a criação de instâncias externas
    
    // MARK: - Métodos de Armazenamento
    
    /// Salva um valor (String) no UserDefaults para uma chave específica.
    func save(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    /// Recupera um valor (String) do UserDefaults baseado na chave, retornando nil se não existir.
    func get(forKey key: String) -> String? {
        return defaults.string(forKey: key)
    }
    
    /// Verifica se um valor existe para a chave informada.
    func exists(forKey key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    /// Remove um valor do UserDefaults baseado na chave.
    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    // MARK: - Métodos para Objetos Codificáveis
    
    /// Salva um objeto codificável no UserDefaults para uma chave específica.
    func save<T: Encodable>(_ value: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: key)
        }
    }
    
    /// Recupera um objeto codificável do UserDefaults baseado na chave, retornando nil se não existir.
    func get<T: Decodable>(forKey key: String) -> T? {
        if let data = defaults.data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
}
