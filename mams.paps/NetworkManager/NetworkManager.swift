import Foundation
import UIKit

final class NetworkManager {
    
    
    //MARK: - Life Cycle
    
    private init() {}
    static  let shared = NetworkManager()
    
    
    //MARK: - Method
    
    func getLocation(completion: @escaping(Result<[Location], NetworkError>) -> Void ) {
        guard let url = URL(string: "https://run.mocky.io/v3/f174e821-b423-4dfc-955a-42fa158b7f6c") else {
            completion(.failure(.noInternet))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.noInternet))
                return
            }
            let code = (response as? HTTPURLResponse)?.statusCode
            if code != 200 {
                print("Status \(String(describing: data))")
                completion(.failure(.noInternet))
                return
            }
            guard let responseData = data else {
                completion(.failure(.noData))
                return
            }
            guard let data = data else {
                print("data is nil")
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoderWModel = try decoder.decode(PlaygroundModel.self, from: data)
                let locations = decoderWModel.playgrounds.map {
                    Location(location: $0)
                }
                completion(.success(locations))
            } catch {
                print("Error occurred: \(error)")
                completion(.failure(.somethingWentWrong))
            }
        }
        task.resume()
    }
}
