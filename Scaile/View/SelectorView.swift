//
//  SelectorView.swift
//  Scaile
//
//  Created by Simon Andersen on 19/05/2023.
//

import SwiftUI

struct SelectorView: View {
    var firstString: String
    var secondString: String
    
    var body: some View {
        if secondString == "Random" {
            Text(secondString)
                .foregroundColor(.red)
                .font(.system(size: 36, weight: .bold, design: .monospaced))
        } else {
            Group {
                Text(firstString + " ")
                    .foregroundColor(.black)
                    .font(.system(size: 36, weight: .bold, design: .monospaced)) +
                
                Text(secondString)
                    .foregroundColor(.red)
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
            }
        }
    }
}

struct SelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView(firstString: "C", secondString: "Major")
    }
}
