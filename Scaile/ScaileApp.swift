//
//  ScaileApp.swift
//  Scaile
//
//  Created by Simon Andersen on 11/04/2023.
//

import SwiftUI

@main
struct ScaileApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    
                    let fm = FileManager.default
                    
                    if let documentDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
                        print(documentDirectory)
                    }
                }
        }
    }
}
