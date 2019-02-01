import Foundation

protocol MetricViewBehavior {
    func set(items: [MetricModel])
    func setSteps(steps: Int)
}

protocol MetricEventHandler: class {
    func load()
    func changeMinSteps(count: Int)
}
