//
//  TimerView.swift
//  Scaile
//
//  Created by Simon Andersen on 18/05/2023.
//

import SwiftUI

struct TimerView: View {
    @State var time: Double = 0.0
    
    let isLoaded: Bool
    let duration: Double?
    
    var body: some View {
        
        if isLoaded, let duration = duration {
            let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
            ProgressView(value: time, total: duration)
                .tint(.red)
                .padding([.leading, .trailing], 100)
                .onReceive(timer) { _ in
                    if time <= duration {
                        time += 0.1
                    } else {
                        time = 0.0
                    }
                }
        } else {
            ProgressView(value: 0.0)
                .tint(.red)
                .padding([.leading, .trailing], 100)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(isLoaded: true, duration: nil)
    }
}
