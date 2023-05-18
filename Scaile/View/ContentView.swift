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
    @State private var showingSheet = false
    
    @State var time: Double = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    

    
    var body: some View {
        ZStack {
            
            VStack {
                Spacer()
                
                Spacer()
                
                Spacer()
                
                if isPlaying, let duration = playerManager.midiPlayer?.duration {
                    ProgressView(value: time, total: duration)
                        .tint(.red)
                        .padding([.leading, .trailing], 100)
                        .onReceive(timer) { _ in
                            if time < duration {
                                time += 0.1
                            }
                        }
                }
                
                Spacer()
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
                    
                } label: {
                    
                    TextGroupView(firstString: isPlaying ? "Stop " : "Play ", secondString: "MIDI")
                    
                }.padding()
            
                
                Button {
                    showingSheet.toggle()
                } label: {
                    TextGroupView(firstString: "Configure ", secondString: "MIDI")
                }
                .sheet(isPresented: $showingSheet) {
                    ConfigView()
                }
                
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
                        TextGroupView(firstString: "Generate ", secondString: "MIDI")
                    }.padding()
                }
                
                // ProgressView().tint(isDownloading ? .red : .clear)
                
                Spacer()
                
            }.padding()
        }
    }
}
