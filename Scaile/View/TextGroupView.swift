//
//  TextGroupView.swift
//  Scaile
//
//  Created by Simon Andersen on 18/05/2023.
//

import SwiftUI

struct TextGroupView: View {
    let firstString: String
    let secondString: String
    
    var body: some View {
        Group {
            Text(firstString)
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .bold, design: .monospaced)) +
            
            Text(secondString)
                .foregroundColor(.red)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
        }
    }
}

struct TextGroupView_Previews: PreviewProvider {
    static var previews: some View {
        TextGroupView(firstString: "Play", secondString: "MIDI")
    }
}
