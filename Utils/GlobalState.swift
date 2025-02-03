//
//  GlobalConstants.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 21.1.25..
//

import Foundation

class GlobalState {
    static let shared = GlobalState()
    
    // Изменяем с let на var, чтобы можно было изменять значение
    private(set) var isRegistered: Bool = false
    
    private init() {}
    
    // Добавляем метод для изменения значения
    func setRegistrationStatus(_ status: Bool) {
        isRegistered = status
    }
}
