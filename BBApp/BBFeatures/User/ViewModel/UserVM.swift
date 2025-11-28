import Foundation

@Observable
final class UserVM {
    var user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
    
    func saveChanges() {
        print("Your changes have been saved")
    }
}
