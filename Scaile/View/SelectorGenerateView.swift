//
//  SelectorGenerateView.swift
//  Scaile
//
//  Created by Simon Andersen on 20/05/2023.
//

import SwiftUI

struct SelectorGenerateView: View {
    var text: String
    var color: Color = .red
    @State var dotsCount = 0
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 24, weight: .bold, design: .monospaced)) +
            
            Text(".")
                .foregroundColor(dotsCount > 0 ? color : .clear)
                .font(.system(size: 24, weight: .bold, design: .monospaced)) +
            
            Text(".")
                .foregroundColor(dotsCount > 1 ? color : .clear)
                .font(.system(size: 24, weight: .bold, design: .monospaced)) +
            
            Text(".")
                .foregroundColor(dotsCount > 2 ? color : .clear)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
        }
        .animation(.easeOut(duration: 0.2), value: dotsCount)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()) { _ in dotsAnimation() }
            .onAppear(perform: dotsAnimation)
    }
    
    func dotsAnimation() {
        withAnimation {
            dotsCount = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                dotsCount = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation {
                dotsCount = 2
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation {
                dotsCount = 3
            }
        }
    }
}

struct SelectorGenerateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorGenerateView(text: "Generating")
    }
}
