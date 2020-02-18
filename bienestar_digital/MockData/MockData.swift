//
//  MockData.swift
//  bienestar_digital
//
//  Created by Sergio on 15/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import Foundation

// Clase para almacenar los datos de los usuarios registrados además de el usuario ya añadido para poder acceder a la aplicación sin BBDD.
class MockData{
    
    public static var MockUpUser = [User.init(email: "admin@gmail.com" , password: "admin123", userName: "admin")]
    
    
    
}

