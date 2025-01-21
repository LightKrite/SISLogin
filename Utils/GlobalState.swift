//
//  GlobalConstants.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 21.1.25..
//

import Foundation


class GlobalState {
    static let shared = GlobalState()

    // Переменная состояния всегда возвращает false
    var isRegistered: Bool {
        return false
    }
}
