import Foundation

struct MetricModel: Decodable {
    var aerobic: Int
    var date: Date
    var run: Int
    var walk: Int
    var steps: Int {
        return run + walk + aerobic
    }
}

