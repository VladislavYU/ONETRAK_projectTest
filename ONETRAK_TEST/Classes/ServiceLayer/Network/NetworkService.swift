import Foundation

class NetworkService {
    
    fileprivate static let requestTimeout: Double = 30
    
    enum Method {
        case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
    }
    
    func addJSONContentType(request: inout URLRequest) {
        if request.allHTTPHeaderFields == nil {
            request.allHTTPHeaderFields = [:]
        }
        request.allHTTPHeaderFields!["Content-type"] = "application/json"
        request.allHTTPHeaderFields!["Accept"] = "application/json"
    }
    
    func request(url: URL,
                 method: Method,
                 params: [String : AnyObject]?,
                 headers: [String: AnyObject]?,
                 completetion: @escaping (Data) -> ()) {
        let request = self.createRequest(url: url, method: method, params: params, headers: headers)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error Request: \(error!)")
                return
            }
            
            if let data = data {
                completetion(data)
            }
        }.resume()
    }
    
    func createRequest(url: URL,
                       method: Method,
                       params: [String : AnyObject]?,
                       headers: [String: AnyObject]?) -> URLRequest {
        
        var requestURL: URL = url
        if let values = params {
            let parameterString = values.stringFromHttpParameters()
            if method == .GET {
                requestURL = URL(string: "\(url)?\(parameterString)")!
            }
        }
        
        var request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: NetworkService.requestTimeout)
        
        if method != .GET, params != nil {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: params!, options: [])
                request.httpBody = bodyData
                
                self.addJSONContentType(request: &request)
            } catch let error{
                print("Body data serialisazion error: \(error)")
            }
        }
        
        return request
    }
}
