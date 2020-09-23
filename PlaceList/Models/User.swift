//
//  User.swift
//  PlaceList
//
//  Created by Vladislav Miroshnichenko on 23.09.2020.
//

import Foundation

struct User {
    
    let name: String
    let surname: String
    let dateOfBirth: Date
    let email: String
    
    init(name: String, surname: String, dateOfBirth: Date, email: String) {
        self.name = name
        self.surname = surname
        self.dateOfBirth = dateOfBirth
        self.email = email
    }
    
}
