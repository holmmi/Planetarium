//
//  EarthAssetsRequest.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 30.11.2021.
//

import Foundation
import UIKit

struct EarthAssetsRequestError: Error {
    enum ErrorKind {
        case noData
        case noImage
    }
    let errorMsg: String
    let errorKind: ErrorKind
}

struct EarthAssetsRequest {
    private let apiKey: String
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        if let unwrappedApiKey = Bundle.main.infoDictionary?["NASA_API_KEY"] as? String {
            self.apiKey = unwrappedApiKey
        } else {
            self.apiKey = "DEMO_KEY"
        }
        self.urlSession = urlSession
    }
    
    func getEarthAssets(latitude: Float, longitude: Float, completion: @escaping (Result<EarthAsset, Error>) -> Void) {
        let date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "date", value: dateFormatter.string(from: date)),
            URLQueryItem(name: "dim", value: "0.15"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/earth/assets")!
        urlComponents.queryItems = queryItems
        
        let task = urlSession.dataTask(with: urlComponents.url!) { (data, response, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    completion(.success(try jsonDecoder.decode(EarthAsset.self, from: data)))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(EarthAssetsRequestError(errorMsg: "No data", errorKind: .noData)))
            }
        }
        task.resume()
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = urlSession.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                completion(.failure(EarthAssetsRequestError(errorMsg: "No data", errorKind: .noData)))
                return
            }
            guard let uiImage = UIImage(data: data) else {
                completion(.failure(EarthAssetsRequestError(errorMsg: "Failed to parse image", errorKind: .noImage)))
                return
            }
            completion(.success(uiImage))
        }
        task.resume()
    }
}
