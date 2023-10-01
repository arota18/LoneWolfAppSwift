//
//  Bundle.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 30/9/23.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from bundle")
        }
        guard let loade = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from bundle")
        }
        return loade
    }
}
