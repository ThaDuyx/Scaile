//
//  ContentView.swift
//  Scaile
//
//  Created by Simon Andersen on 11/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Group {
                Text("Sc")
                    .font(.system(size: 26, weight: .bold, design: .monospaced)) +
                
                Text("ai")
                    .foregroundColor(.red)
                    .font(.system(size: 26, weight: .bold, design: .monospaced)) +
                
                Text("le")
                    .font(.system(size: 26, weight: .bold, design: .monospaced))
            }
            
            Spacer()
            
            Button {
                if PlayerManager.shared.isMIDIPlayerPlaying() {
                    PlayerManager.shared.stopMIDIPlayer()
                } else {
                    PlayerManager.shared.playMIDI()
                }
            } label: {
                Group {
                    Text("Play ")
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
            
            Button {
                FlaskManager.shared.getString()
            } label: {
                Group {
                    Text("Get ")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .bold, design: .monospaced)) +
                    
                    Text("Data")
                        .foregroundColor(.red)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                }
                
            }.padding()
            
            Button {
                FlaskManager.shared.generateAndFetchMIDI()
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
            
            Spacer()
            
        }.padding()
    }
}
