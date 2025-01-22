import UIKit

class CreatePinViewModel {
    init() {
        print("CreatePinViewModel initialized")
    }
    
    func getScreenTitle() -> String {
        return "Код приложения"
    }
    
    func getMainTitle() -> String {
        return "Создайте код приложения"
    }
    
    func getSubtitle() -> String {
        return "Введите код из символов"
    }
}
