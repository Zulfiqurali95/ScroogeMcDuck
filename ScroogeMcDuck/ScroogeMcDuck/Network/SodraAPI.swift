import Foundation

// Use for any API conformance
protocol API {
    func post(data: Data, session: URLSession, completion: @escaping (Result<Data, Error>) -> Void)
    /* Remaining CRUD calls
     func get()
     func update()
     func delete()
     */
}

enum SodraAPI: API {
    
    case samplePostPath(_ param1: String, _ param2: String)
    case defaultPath

    private var request: URLRequest? {
        switch self {
        case .samplePostPath(let param1, let param2):
            var components = URLComponents(string: "https:SamplePostPath")
            components?.queryItems = [
                URLQueryItem(name: "param1", value: param1),
                URLQueryItem(name: "param2", value: param2)
            ]
            guard let url = components?.url else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        case .defaultPath:
            guard let url = URL(string: "https:Default") else { return nil }
            return URLRequest(url: url)
        }
    }
    
    func post(data: Data, session: URLSession, completion: @escaping (Result<Data, Error>) -> Void) {
        // Call URLSession here to make a network request
        /*
         guard let request else {
            completion(.failure(...))
            return
         }
         session.dataTask(with: request) { data, response, error in
             // error check first
         
            // if pass, success
            completion(.success(data))
            
         }.resume()
         */
        
        // Firing a success here to simulate the basic happy path. Actual code would be above but completed
        completion(.success(data))
    }
}

