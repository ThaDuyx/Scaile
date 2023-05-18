//
//  ConfigView.swift
//  Scaile
//
//  Created by Simon Andersen on 18/05/2023.
//

import SwiftUI

struct ConfigView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var configManager: ConfigManager
    
    var key = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    var scale = ["Major", "Minor"]
    
    @State private var selectedKey = "C"
    @State private var selectedScale = "Major"
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(spacing: 10) {
                Group {
                    Text(configManager.selectedKey + " ")
                        .foregroundColor(.black)
                        .font(.system(size: 36, weight: .bold, design: .monospaced)) +
                    
                    Text(configManager.selectedScale)
                        .foregroundColor(.red)
                        .font(.system(size: 36, weight: .bold, design: .monospaced))
                }
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 100, height: 1)
                
            }
            .padding()
            
            HStack(alignment: .center) {
                TextGroupView(firstString: "Key: ", secondString: "")
                
                Picker("Please choose a color", selection: $configManager.selectedKey) {
                    ForEach(key, id: \.self) {
                        Text($0)
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(.red)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 150, height: 100)
            }
            
            HStack(alignment: .center) {
                TextGroupView(firstString: "Scale: ", secondString: "")
                
                Picker("Please choose a color", selection: $configManager.selectedScale) {
                    ForEach(scale, id: \.self) {
                        Text($0)
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(.red)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 150, height: 100)
            }
            
            Spacer()
            
            Button() {
                dismiss()
            } label: {
                TextGroupView(firstString: "Close ", secondString: "Selection")
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
