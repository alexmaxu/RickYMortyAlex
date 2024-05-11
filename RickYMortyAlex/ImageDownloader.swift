//
//  ImageDownloader.swift
//  RickYMortyAlex
//
//  Created by Alex  on 10/5/24.
//
import SwiftUI
import Foundation

actor ImageDownloader {
    static let shared = ImageDownloader()
    
    private enum ImageStatus {
        case downloading(task: Task<UIImage, Error>)
        case downloaded(image: UIImage)
    }
    
    private var imageCache: [URL:ImageStatus] = [:]
    
    private func getImage(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let imagen = UIImage(data: data) {
            return imagen
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    func image(url: URL) async throws -> UIImage {
        if let imageStatus = imageCache[url] {
            switch imageStatus {
            case .downloading(let task):
                return try await task.value
            case .downloaded(let image):
                return image
            }
        }
        
        let task = Task {
            try await getImage(url: url)
        }
        
        imageCache[url] = .downloading(task: task)
        
        do {
            let image = try await task.value
            imageCache[url] = .downloaded(image: image)
            try await saveImage(url: url)
            return image
        } catch {
            imageCache.removeValue(forKey: url)
            throw error
        }
    }
    
    private func saveImage(url: URL) async throws {
        guard let imageStatus = imageCache[url] else { return }
        
        let path = url.lastPathComponent
        let urlCacheDirectory = URL.cachesDirectory.appending(path: path)
        print(urlCacheDirectory)
        if case .downloaded(let image) = imageStatus {
            let data = image.heicData()
            try data?.write(to: urlCacheDirectory, options: .atomic)
            imageCache.removeValue(forKey: url)
        }
    }
}
