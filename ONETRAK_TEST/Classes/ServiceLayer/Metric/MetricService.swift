import Foundation

protocol MetricService {
    func fetchMetric(complatition: @escaping ([MetricModel]) -> ())
}

class MetricServiceImp: MetricService {
    
    var request = NetworkService()
    var parser = JSONParser()
    let url = "https://intern-f6251.firebaseio.com/intern/metric.json"
    
    init() {
    }
    
    func fetchMetric(complatition: @escaping ([MetricModel]) -> ()) {
        request.request(url: URL(string: url)!, method: .GET, params: nil, headers: nil) { (data) in
            let result = self.parser.mapObject([MetricModel].self, data: data)
            complatition(result)
        }
    }
    
}
