//
//  FileManager.swift
//  Scaile
//
//  Created by Simon Andersen on 15/05/2023.
//

import Foundation

class FlaskManager: NSObject, ObservableObject {
    
    static let shared = FlaskManager()
    
    var destinationPath: URL?
    
    func generateMIDI() {
        guard let url = URL(string: "http://127.0.0.1:5500/generate") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Error: \(httpResponse.statusCode)")
                guard httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else { return }
            }
            
            guard let data = data else { print("Data is empty") ; return }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(FlaskData.self, from: data)
                print("Data: \(result)")
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func generateAndFetchMIDI(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5500/generate") else {
            print("No URL returned")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { fileUrl, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let destinationPath = documentsPath.appendingPathComponent("chord.mid")
            
            guard let fileUrl else {
                print("ERROR: Invalid data")
                return
            }
            
            do {
                try FileManager.default.moveItem(at: fileUrl, to: URL(filePath: destinationPath))
                
                DefaultManager.shared.midiLocation = destinationPath
                
                print("MIDI file successfully downloaded to path \(destinationPath)")
                
                completion()
            } catch {
                print("Error downloading file \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func getString() {
        guard let url = URL(string: "http://127.0.0.1:5500/data") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Error: \(httpResponse.statusCode)")
                guard httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else { return }
            }
            
            guard let data = data else { print("Data is empty") ; return }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(FlaskData.self, from: data)
                print("Data: \(result)")
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getMIDI() {
        guard let url = URL(string: "http://127.0.0.1:5500/midi") else {
            print("No URL returned")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { fileUrl, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let destinationPath = documentsPath.appendingPathComponent("chord.mid")
            
            guard let fileUrl else {
                print("ERROR: Invalid data")
                return
            }
            
            do {
                try FileManager.default.moveItem(at: fileUrl, to: URL(filePath: destinationPath))
                
                DefaultManager.shared.midiLocation = destinationPath
                
                print("MIDI file successfully downloaded to path \(destinationPath)")
            } catch {
                print("Error downloading file \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func getMIDIWithArgs(scale: String) {
        guard let baseUrl = URL(string: "http://127.0.0.1:5500/generate") else {
            print("No URL returned")
            return
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "scale", value: scale)
        ]
        guard let url = components.url else { fatalError("Failed to create URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.downloadTask(with: url) { fileUrl, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let destinationPath = documentsPath.appendingPathComponent("file.mid")
            
            guard let fileUrl else {
                print("ERROR: Invalid data")
                return
            }
            
            do {
                try FileManager.default.moveItem(at: fileUrl, to: URL(filePath: destinationPath))
                
                DefaultManager.shared.midiLocation = destinationPath
                
                print("MIDI file successfully downloaded to path \(destinationPath)")
            } catch {
                print("Error downloading file \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
