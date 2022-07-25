import Alamofire
import Foundation

protocol HttpService {
    func makeRequest<T: Codable>(endpoint: APIConstants.Endpoints, parameters: [String: String?]?, result: @escaping(Result<T, ServiceError>) -> Void)
}

final class HttpServiceImpl : HttpService {

    func makeRequest<T: Codable>(endpoint: APIConstants.Endpoints, parameters: [String: String?]?, result: @escaping(Result<T, ServiceError>) -> Void) {
        
        AF.request(endpoint.urlString, parameters: parameters).responseData { data in
            switch data.result {
            case .success(let body):
                if let contentType = data.response?.allHeaderFields["Content-Type"] as? String,
                    contentType.contains("application/json") {
                    do {
                        let response = try JSONDecoder().decode(T.self, from: body)
                        
                        return result(.success(response))
                    } catch {
                        print("Unexpected error: \(error).")
                        result(.failure(ServiceError.parseError))
                    }
                }
            case let .failure(error):
                print("Unexpected error: \(error).")
                result(.failure(ServiceError.badRequest))
            }
        }
    }
}