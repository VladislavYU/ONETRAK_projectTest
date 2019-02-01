//
//  MetricCollectionViewController.swift
//  ONETRAK_TEST
//
//  Created by Vladislav Zakharchenko on 01/02/2019.
//  Copyright © 2019 Vladislav Zakharchenko. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MetricCollectionViewCell"

class MetricViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [MetricModel] = []
    var presenter: MetricEventHandler?
    
    private var minSteps: Int = 10000
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationController()
        self.presenter?.load()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.load()
    }
    
    private func setupNavigationController() {
        self.navigationItem.title = "Steps"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
    }
    
    @objc private func edit() {
        let alert = UIAlertController(title: "New goal steps", message: nil, preferredStyle: .alert)
        alert.addTextField { (textFiled) in
            textFiled.keyboardType = .numberPad
            textFiled.placeholder = ""
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] action in
            let text = alert?.textFields?[0].text
            if text != "" {
                self.presenter?.changeMinSteps(count: Int(text!)!)
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    @objc private func add() {
        self.presenter?.load()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MetricCollectionViewCell
        
        cell.setSteps(count: self.minSteps)
        cell.config(model: self.items[indexPath.row])
        // Configure the cell
        
        return cell
    }
}

extension MetricViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let model = items[indexPath.row]
        if model.steps < self.minSteps {
            return CGSize(width: self.view.frame.width, height: 100)
        } else {
            return CGSize(width: self.view.frame.width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.2)
    }
}

extension MetricViewController: MetricViewBehavior {
    func setSteps(steps: Int) {
        self.minSteps = steps
        UIView.animate(withDuration: 2) {
            self.collectionView.reloadData()
        }
    }
    
    
    func set(items: [MetricModel]) {
        self.items = items
        self.collectionView.reloadData()
    }
    
    
}
