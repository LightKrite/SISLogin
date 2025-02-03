//
//  SMSCodeViewModel.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 20.1.25..
//

import Foundation

class SMSCodeViewModel {
    private let validCode = "123456" // Заглушка для проверки кода

    func validateCode(_ code: String) -> Bool {
        // Проверяем, что код не пустой
        if code.isEmpty { return false }
        
        // Проверяем, что код совпадает с validCode
        return code == validCode
    }

}
