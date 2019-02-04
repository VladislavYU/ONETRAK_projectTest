//
//  MetricCollectionViewCell.swift
//  ONETRAK_TEST
//
//  Created by Vladislav Zakharchenko on 01/02/2019.
//  Copyright © 2019 Vladislav Zakharchenko. All rights reserved.
//

import UIKit

class MetricCollectionViewCell: UICollectionViewCell {
    
    var metric: MetricModel?
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var stepsLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var walkLabel: UILabel!
    @IBOutlet var aerobicLabel: UILabel!
    @IBOutlet var runLabel: UILabel!
    
    private var countSteps: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(model: MetricModel){
        self.metric = model
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        
        self.dateLabel.text = formatter.string(from: model.date)
        self.stepsLabel.text = "\(model.steps) / \(self.countSteps!) steps"
        self.walkLabel.text = model.walk.description
        self.runLabel.text = model.run.description
        self.aerobicLabel.text = model.aerobic.description
        
        
    }
    
    func setSteps(count: Int) {
        self.countSteps = count
    }
    
    private func setupProgressView() {
        
    }
    

}
