//
//  FileUtil.swift
//  PlanetariumApplicationTests
//
//  Created by Mikael Holm on 19.11.2021.
//

import Foundation

enum FileUtilError: Error {
    case fileNotFound(String)
}

struct FileUtil {
    static func readJsonFromFile(fileName: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw FileUtilError.fileNotFound("JSON file \(fileName) not found.")
        }
        return try Data(contentsOf: url)
    }
}
