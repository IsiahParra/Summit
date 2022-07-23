//
//  SettingsViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/23/22.
//

import Foundation

class SettingsViewModel {
    private var service: FirebaseSyncable
    
    init(service:FirebaseSyncable = FirebaseService()) {
        self.service = service
    }
    
    func logOut() {
        service.logoutUser()
        UserDefaults.standard.removeObject(forKey: "email")
    }
    
}



