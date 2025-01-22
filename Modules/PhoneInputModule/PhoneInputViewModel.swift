//
//  PhoneInputViewModel.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import Foundation

//class PhoneInputViewModel {
//    private let isRegistration: Bool
//
//    init(isRegistration: Bool = false) {
//        self.isRegistration = isRegistration
//        print("PhoneInputViewModel initialized with isRegistration: \(isRegistration)")
//    }
//
//    func getScreenTitle() -> String {
//        return isRegistration ? "Регистрация" : "Вход"
//    }
//
//    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
//        // Логика валидации может различаться для регистрации и входа
//        if isRegistration {
//            // Допустим, для регистрации проверяем, что номер уникален (заглушка)
//            return phoneNumber.starts(with: "+7") && phoneNumber.count == 11
//        } else {
//            // Для входа проверяем только формат
//            return phoneNumber.starts(with: "+7") && phoneNumber.count == 11
//        }
//    }
//}

//class PhoneInputViewModel {
//    private let isRegistration: Bool
//
//    init(isRegistration: Bool) {
//        self.isRegistration = isRegistration
//        print("PhoneInputViewModel initialized with isRegistration: \(isRegistration)")
//    }
//
//    func getScreenTitle() -> String {
//        return isRegistration ? "Регистрация" : "Вход"
//    }
//
//    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
//            // Логика валидации может различаться для регистрации и входа
//            if isRegistration {
//                // Допустим, для регистрации проверяем, что номер уникален (заглушка)
//                return phoneNumber.starts(with: "+7") && phoneNumber.count == 11
//            } else {
//                // Для входа проверяем только формат
//                return phoneNumber.starts(with: "+7") && phoneNumber.count == 11
//            }
//        }
//}

class PhoneInputViewModel {
    private let isRegistered: Bool

    init() {
        self.isRegistered = GlobalState.shared.isRegistered
        print("PhoneInputViewModel initialized with isRegistered: \(isRegistered)")
    }

    func getScreenTitle() -> String {
        return isRegistered ? "Вход" : "Регистрация"
    }

    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        if phoneNumber.isEmpty { return false }
        if !phoneNumber.starts(with: "+7") || phoneNumber.count != 12 { return false }

        if !isRegistered {
            print("Дополнительная проверка для регистрации")
            return true
        }

        return true
    }
}
