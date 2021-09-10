//
//  AuthValidators.swift
//  cleanerLife
//
//  Created by Adam Berard on 2/3/21.
//

import Foundation

func validateEmail(email: String)->String{
    if(email == "") {return "Please enter a valid email."}
    return "valid"
}

func validatePassword(password: String)->String{
    if(password == "") {return "Please enter a password."}
    return "valid"
}
