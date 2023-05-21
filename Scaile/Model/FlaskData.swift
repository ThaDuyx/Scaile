//
//  FlaskData.swift
//  Scaile
//
//  Created by Simon Andersen on 15/05/2023.
//

import Foundation

struct FlaskData: Codable {
    let name: String
    let description: String
    let version: String
}

struct FlaskRequest: Codable {
    let key: String
    let scale: String
}
