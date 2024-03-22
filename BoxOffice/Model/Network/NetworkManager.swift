
import Foundation

struct NetworkManager {

    private var urlComponents = URLComponents()

    func fetchData<T: Codable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let urlSession = URLSession.shared
        
        guard let url = URL(string: url) else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(FetchError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                completion(.failure(FetchError.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(FetchError.invalidData))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(FetchError.decodingError))
                return
            }
            completion(.success(decodedData))
            
        }.resume()
    }
    
    mutating func modifyUrlComponent(path: String) -> URL? {
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = "/kobisopenapi/webservice/rest\(path)"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "ab168a1eb56e21306b897acd3d4653ce")
        ]
        
        return urlComponents.url
    }
}



