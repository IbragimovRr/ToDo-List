//
//  UD.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation

class UD {
    
    func saveCurrent(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "current")
    }
    
    func getCurrent() -> Bool {
        return UserDefaults.standard.bool(forKey: "current")
    }
}
