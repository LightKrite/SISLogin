//
//  PhoneInputViewModel.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import Foundation

class PhoneInputViewModel {
    private let isRegistered: Bool

    init() {
        self.isRegistered = GlobalState.shared.isRegistered
        print("PhoneInputViewModel initialized with isRegistered: \(isRegistered)")
    }

    func getScreenTitle() -> String {
        return isRegistered ? "Войти" : "Зарегистрироваться"
    }

    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        // Проверяем, что строка не пустая
        if phoneNumber.isEmpty { return false }
        
        // Проверяем длину номера (должно быть 10 цифр)
        if phoneNumber.count != 10 { return false }
        
        // Проверяем, что строка содержит только цифры
        let digits = CharacterSet.decimalDigits
        let phoneSet = CharacterSet(charactersIn: phoneNumber)
        if !digits.isSuperset(of: phoneSet) { return false }
        
        if !isRegistered {
            print("Дополнительная проверка для регистрации")
            return true
        }
        
        return true
    }
}
