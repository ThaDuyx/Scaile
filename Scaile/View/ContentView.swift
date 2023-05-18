//
//  ContentView.swift
//  Scaile
//
//  Created by Simon Andersen on 11/04/2023.
//

import SwiftUI
import SwimplyPlayIndicator
import Shimmer

struct ContentView: View {
    @StateObject var playerManager = PlayerManager()
    
    @State var isPlaying: Bool = false
    @State var isDownloading: Bool = false
    
    @State var time: Double = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            VStack {
                Spacer()
                if playerManager.isLoaded, let duration = playerManager.midiPlayer?.duration {
                    ProgressView(value: time, total: duration)
                        .tint(.red)
                        .padding([.leading, .trailing], 100)
                        .onReceive(timer) { _ in
                            if time < duration {
                                time += 0.1
                            }
                        }
                }
            }
            
            
            VStack {
                HeaderView()
                
                Spacer()
                
                Button {
                    if playerManager.isMIDIPlayerPlaying() {
                        playerManager.stopMIDIPlayer()
                        time = 0.0
                    } else {
                        isPlaying.toggle()
                        playerManager.playMIDI() {
                            time = 0.0
                            isPlaying.toggle()
                        }
                    }
                    
                    // isPlaying.toggle()
                    isDownloading.toggle()
                } label: {
                    Group {
                        Text(isPlaying ? "Stop ": "Play ")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold, design: .monospaced)) +
                        
                        Text("MIDI")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                    }
                    
                }.padding()
                
                Button {
                    FlaskManager.shared.getMIDI()
                } label: {
                    Group {
                        Text("Get ")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold, design: .monospaced)) +
                        
                        Text("MIDI")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                    }
                }.padding()
                
                if isDownloading {
                    GeneratingView()
                        .padding()
                } else {
                    Button {
                        isDownloading.toggle()
                        /*
                         FlaskManager.shared.generateAndFetchMIDI() {
                         isDownloading = false
                         }
                         */
                    } label: {
                        Group {
                            Text("Generate ")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                            
                            Text("MIDI")
                                .foregroundColor(.red)
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                        }
                    }.padding()
                }
                
                ProgressView()
                    .tint(isDownloading ? .red : .clear)
                
                Spacer()
                
            }.padding()
        }
    }
}
