import Foundation

final class SaveData {
    
    var movieLiked: Bool!
    let defaults = UserDefaults.standard
    
    func saveInUserDefault(forKey: String) {
        self.defaults.set(movieLiked, forKey: forKey)
    }
}
