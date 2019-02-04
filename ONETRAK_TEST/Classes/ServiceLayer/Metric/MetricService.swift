import Foundation

protocol MetricService {
    func fetchMetric(complatition: @escaping ([MetricModel]?, Error?) -> ())
}

class MetricServiceImp: MetricService {
    
    var request = NetworkService()
    var parser = JSONParser()
    let url = "https://intern-f6251.firebaseio.com/intern/metric.json"
    
    init() {
    }
    
    func fetchMetric(complatition: @escaping ([MetricModel]?, Error?) -> ()) {
        request.request(url: URL(string: url)!, method: .GET, params: nil, headers: nil) { data, error  in
            guard error == nil else {
                complatition(nil, error!)
                return
            }
            
            
            let result = self.parser.mapObject([MetricModel].self, data: data!)
            complatition(result, nil)
        }
    }
    
}
