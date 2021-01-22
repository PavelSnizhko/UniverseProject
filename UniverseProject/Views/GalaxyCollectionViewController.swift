//
//  GalaxyCollectionViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 22.01.2021.
//

import UIKit


class GalaxyCollectionViewController: UICollectionViewController {

    var galaxies: [Compose] = []
    let cellId = String(describing: CollectionViewCell.self)


    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: cellId)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.updateGalaxyAfterAdding),
//            name: Notification.Name("galaxyAdded"),
//            object: nil)
//        createTimer()
//        self.collectionView.reloadData()
       // Do any additional setup after loading the view.
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(galaxies.count)
        return galaxies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }

    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? CollectionViewCell else { return }
        let element = galaxies[indexPath.row]
        myCell.name = "\(element.id)"
        myCell.descriptionItem = element.smallDescription()
    }

}



//extension GalaxyCollectionViewController {
//
//    @objc func updateGalaxyAfterAdding() {
//        galaxies.append()
//    }
//
//
//    @objc func handleNotification() {
//        self.universe.(10)
//
//        self.collectionView?.performBatchUpdates({
//            let indexPath = IndexPath(row: self.universes.count, section: 0)
//            universes.append(universe)
//            self.collectionView?.insertItems(at: [indexPath])
//        }, completion: nil)
//    }
//
//    func createTimer() {
//      if timer == nil {
//        let timer = Timer(timeInterval: 1.0,
//          target: self,
//          selector: #selector(handleTimeInterval),
//          userInfo: nil,
//          repeats: true)
//        RunLoop.current.add(timer, forMode: .common)
////        timer.tolerance = 0.1
//
//        self.timer = timer
//      }
//
//    }
//
//}
//
//
//}
