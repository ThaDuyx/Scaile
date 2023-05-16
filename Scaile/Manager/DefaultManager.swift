//
//  DefaultManager.swift
//  Scaile
//
//  Created by Simon Andersen on 15/05/2023.
//

import Foundation

class DefaultManager {
    
    static let shared = DefaultManager()
    
    private let defaults = UserDefaults.standard
    
    private enum Key: String {
        case midiLocation = "DefaultsManager_midiLocation"
    }
    
    var midiLocation: String? {
        get {
            return defaults.string(forKey: Key.midiLocation.rawValue)
        }
        
        set {
            defaults.set(newValue, forKey: Key.midiLocation.rawValue)
            defaults.synchronize()
        }
    }
}
