//
//  LaunchView.swift
//  Scaile
//
//  Created by Simon Andersen on 16/05/2023.
//

import SwiftUI

struct LaunchView: View {
    @State private var isAnimating = true
    
    var body: some View {
        VStack {
            Spacer()
            
            groupView
                .scaleEffect(isAnimating ? 0.1 : 1)
                .animation(.easeInOut(duration: 1.5), value: isAnimating)
                .onAppear {
                    isAnimating = false
                }
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                
            }
        }
    }
    
    private var groupView: some View {
        Group {
            Text("Sc")
                .font(.system(size: 38, weight: .bold, design: .monospaced)) +
            
            Text("ai")
                .foregroundColor(.red)
                .font(.system(size: 38, weight: .bold, design: .monospaced)) +
            
            Text("le")
                .font(.system(size: 38, weight: .bold, design: .monospaced))
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
