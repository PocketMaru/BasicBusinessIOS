//
//  UserVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

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
    
    func updatedProfileImage(with data: Data) {
        user.profileImageData = data
        saveChanges()
    }
}
