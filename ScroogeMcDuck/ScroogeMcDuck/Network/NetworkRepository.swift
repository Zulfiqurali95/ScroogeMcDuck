import Foundation

// Used for the top level networking level
protocol Network {
    func get<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
    func post<T: Codable>(with model: T, completion: @escaping (Result<T, Error>) -> Void)
    func update<T: Codable>(with model: T, completion: @escaping (Result<T, Error>) -> Void)
    func delete(completion: @escaping (Result<Data?, Error>) -> Void)
}

// Created other CRUD operations as an example, but only post is used for this context
class NetworkRepository: Network {
    
    private let api: API
    
    init(api: API) {
        self.api = api
    }
    
    // Responsible for the conversions, could be cleaner
    func post<T>(with model: T, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        do {
            let data = try JSONEncoder().encode(model)
            api.post(data: data, session: URLSession.shared) { result in
                switch result {
                case .success(let data):
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func get<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        // Call API GET call
    }
    
    func update<T>(with model: T, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        // Call API PUT call
    }
    
    func delete(completion: @escaping (Result<Data?, Error>) -> Void) {
        // Call API DELETE call
    }
}
