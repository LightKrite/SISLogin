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
        return code == validCode
    }

    func isCodeValid(_ code: String) -> Bool {
        // Для тестирования можно использовать любой непустой код
        // В реальном приложении здесь будет проверка с бэкендом
        print("Validating SMS code: \(code)")
        return !code.isEmpty
    }
}
