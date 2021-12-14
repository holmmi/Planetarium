//
//  APODRequest.swift
//  Planetarium (iOS)
//
//  Created by Mikael Holm on 3.11.2021.
//

import Foundation

struct APODRequest {
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
    
    func getPictureInfos(startDate: Date, endDate: Date, completion: @escaping (Result<[PictureInfo], Error>) -> Void) -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [
            "api_key": self.apiKey,
            "start_date": dateFormatter.string(from: startDate),
            "end_date": dateFormatter.string(from: endDate),
            "thumbs": "true"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let task = urlSession.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let pictureInfos = try jsonDecoder.decode([PictureInfo].self, from: data)
                    completion(.success(pictureInfos.sorted { (a, b) -> Bool in
                        return a.date > b.date
                    }))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getRandomPictures(picAmount: Int, completion: @escaping (Result<[PictureInfo], Error>) -> Void) -> Void {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [
            "api_key": self.apiKey,
            "count": String(picAmount),
            "thumbs": "true"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let task = urlSession.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let pictureInfos = try jsonDecoder.decode([PictureInfo].self, from: data)
                    completion(.success(pictureInfos.sorted { (a, b) -> Bool in
                        return a.date > b.date
                    }))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
