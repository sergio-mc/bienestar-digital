import Foundation

// Clase de estructuración de el código de respuesta
struct RegisterResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var user: User?
    

    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case user
    }
    
}

