//
//  Mapper.swift
//  mams.paps
//
//  Created by Kos on 07.03.2024.
//

import Foundation

protocol CoreMapperProtocol {
    func map<T: Decodable>(from data: Data, jsonType: T.Type) async throws -> T
}

final class CoreMapper {
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}

extension CoreMapper: CoreMapperProtocol {
    func map<T>(from data: Data, jsonType: T.Type) async throws -> T where T : Decodable {
//        print(String(data: data, encoding: .utf8)!)
        do {
            let model = try decoder.decode(jsonType.self, from: data)
            return model

        } catch let error as DecodingError {
            switch error {
            case .typeMismatch(let any, let context):
                print("typeMismatch: (any), (context)")
            case .valueNotFound(let any, let context):
                print("valueNotFound: (any), (context)")
            case .keyNotFound(let codingKey, let context):
                print("keyNotFound: (codingKey), (context)")
            case .dataCorrupted(let context):
                print("dataCorrupted: (context)")
            @unknown default:
                assertionFailure()
            }
            throw error
        } catch {
            print("ответ из API: Не удалось спарсить данные")
            print(error.localizedDescription)
            throw NetworkError.noData
        }
    }
}
