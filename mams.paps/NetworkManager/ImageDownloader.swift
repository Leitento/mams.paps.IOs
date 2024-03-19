//
//  ImageDownloader.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 19.03.2024.
//

import UIKit

final class ImageDownloader {
    static let shared = ImageDownloader()
    func getImage(url: String, completion: @escaping ((_ image: UIImage?) -> Void)) {
        guard let url = URL(string: url) else {
           completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error
            { return }
            guard let data else {return}
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
