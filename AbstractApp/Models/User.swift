

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var phone: String
    var address: String
    var birthDate: String
    
    static func getDefaultUser() -> User {
        return User(
            name: "Steve Jobs",
            email: "stevejobos@apple.com",
            phone: "(11) 98765-4321",
            address: "Av. Paulista, 1000 - São Paulo, SP",
            birthDate: "24/02/1955"
        )
    }
} 