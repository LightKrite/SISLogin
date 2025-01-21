//
//  PhoneInputViewModel.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import Foundation

class PhoneInputViewModel {
    private let isRegistration: Bool

    init(isRegistration: Bool) {
        self.isRegistration = isRegistration
    }

    func getScreenTitle() -> String {
        return isRegistration ? "Регистрация" : "Вход"
    }

    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        // Логика валидации может различаться для регистрации и входа
        if isRegistration {
            // Допустим, для регистрации проверяем, что номер уникален (заглушка)
            return phoneNumber.starts(with: "+7") && phoneNumber.count == 12
        } else {
            // Для входа проверяем только формат
            return phoneNumber.starts(with: "+7") && phoneNumber.count == 12
        }
    }
}
