//
//  ViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var modelGenerator = ModelGenerator()
    var universe: Compose?
//    var data = [("Pasha", "1234567"), ("Dasha", "534534"), ("Sasha", "142343267")]
    let cellId = String(describing: CollectionViewCell.self)
    weak var timer: Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        self.universe = self.modelGenerator.createUniverse()
//        createTimer()
//        self.collectionView.reloadData()
       // Do any additional setup after loading the view.
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? CollectionViewCell else { return }
        let element = self.universe!
        myCell.name = "\(element.id)"
        myCell.descriptionItem = element.smallDescription()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let universe = self.universe as? Universe {
            print("Я тут")
            let galaxyCollectionVC = storyboard?.instantiateViewController(withIdentifier: "GalaxyCollectionViewController") as! GalaxyCollectionViewController
//            present(sb, animated: true, completion: nil)?
//            galaxyCollectionVC.galaxies = universe.contentArray
            navigationController?.pushViewController(galaxyCollectionVC, animated: true)
        }
    }

}

//extension CollectionViewController {
//    
////    @objc func handleTimeInterval() {
////        self.universe!.handleTimePeriod(timeInterval: 10, universeRule: <#UniverseRule#>)
////
//////        self.collectionView?.performBatchUpdates({
//////            let indexPath = IndexPath(row: self.universes.count, section: 0)
//////            universes.append(universe)
//////            self.collectionView?.insertItems(at: [indexPath])
//////        }, completion: nil)
////    }
////
////    func createTimer() {
////      if timer == nil {
////        let timer = Timer(timeInterval: 5.0,
////          target: self,
////          selector: #selector(handleTimeInterval),
////          userInfo: nil,
////          repeats: true)
////        RunLoop.current.add(timer, forMode: .common)
//////        timer.tolerance = 0.1
////
////        self.timer = timer
////      }
//        
//    }
//        
//}
