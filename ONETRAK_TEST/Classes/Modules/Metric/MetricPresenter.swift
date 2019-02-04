import Foundation

class MetricPresenter: MetricEventHandler {
    var view: MetricViewBehavior?
    
    let metricService: MetricService
    
    var minSteps: Int?
    
    init(view: MetricViewBehavior, metricService: MetricService) {
        self.view = view
        self.metricService = metricService
    }
    
    func load() {
        self.view?.startLoader()
        self.getMetric { (models) in
            DispatchQueue.main.async {
                self.view?.set(items: models)                
            }
        }
    }
    
    func changeMinSteps(count: Int) {
        self.view?.setSteps(steps: count)
    }
    
    private func getMetric(complatition: @escaping ([MetricModel]) -> ()) {
        metricService.fetchMetric { [weak self] (models, error)  in
            guard let models = models else {
                self?.view?.stopLoader()
                return
            }
            complatition(models)
            self?.view?.stopLoader()
        }
    }
    
    
}
