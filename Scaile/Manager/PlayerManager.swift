//
//  PlayerManager.swift
//  Scaile
//
//  Created by Simon Andersen on 11/04/2023.
//

import Foundation
import AVFoundation

@MainActor class PlayerManager: NSObject, ObservableObject {
    
    @Published var isLoaded: Bool = false
    
    static let shared = PlayerManager()
    
    public var midiPlayer: AVMIDIPlayer?
    
    private let fileManager = FileManager.default
    
    // MARK: - Midi player functionality
    
    func isMIDIPlayerPlaying() -> Bool {
        guard let midiPlayer = midiPlayer else { return false }
        
        return midiPlayer.isPlaying
    }
    
    func stopMIDIPlayer() {
        midiPlayer?.stop()
        midiPlayer = nil
        isLoaded.toggle()
    }
    
    func playMIDI(completion: @escaping () -> Void) {
        guard let soundBankURL  = Bundle.main.url(forResource: "Piano", withExtension: "sf2") else { return }
        
        // - Commented but sometimes used for test purposes
        // guard let fileUrl = Bundle.main.url(forResource: "output", withExtension: "mid") else { print("MIDI file not found."); return }
        
        do {
            guard let midiUrl = fetchMIDIUrl() else { return }
            
            midiPlayer = try AVMIDIPlayer(contentsOf: midiUrl, soundBankURL: soundBankURL)
            
            isLoaded.toggle()
            
            midiPlayer?.prepareToPlay()
            midiPlayer?.play() {
                self.midiPlayer = nil
                completion()
            }
        } catch {
            print("Failed to load the MIDI file or soundbank \(error.localizedDescription)")
        }
    }
    
    private func fetchMIDIUrl() -> URL? {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let midiUrl = documentDirectory.appendingPathComponent("chord.mid")
        
        guard fileManager.fileExists(atPath: midiUrl.path) else { return nil }
        
        return midiUrl
    }
}
