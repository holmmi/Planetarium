//
//  EarthAssetsRequest.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 30.11.2021.
//

import Foundation

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
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: Date())
        let date = calendar.date(from: components)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let queryItems = [
            URLQueryItem(name: "lat", value: latitude.formatted()),
            URLQueryItem(name: "lon", value: longitude.formatted()),
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
            }
        }
        task.resume()
    }
}
