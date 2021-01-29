//
//  ViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import UIKit


protocol ReloadDataDelegate: class {
    func reloadData(component: Compose?)
}


class UniverseViewController: UIViewController {
    
    var modelGenerator = ModelGenerator()
    var universe: Compose?
    let cellId = String(describing: CollectionViewCell.self)
    weak var timer: Timer?
    weak var galaxyViewController: GalaxyViewController?

    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUICollectionView(cellId: cellId)
        self.universe = self.modelGenerator.createUniverse(reloadDataDelegate: self)

    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
}

extension UniverseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? CollectionViewCell, let component = self.universe else { return }
        myCell.update(component: component)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let universe = self.universe as? Universe {
            let galaxyVC = storyboard?.instantiateViewController(withIdentifier: "GalaxyViewController") as! GalaxyViewController
            galaxyViewController = galaxyVC
            
            //            present(sb, animated: true, completion: nil)?
            galaxyVC.galaxies = universe.getComponents()
            navigationController?.pushViewController(galaxyVC, animated: true)
        }
    }
}

extension UniverseViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        //change using delegate maybe?
        if let component = component {
            galaxyViewController?.appendNewCell(compenent: component)
            print("Я ДОБАВЛЯЛ ЧЕСТНО !!!!")
            print(galaxyViewController)
        }
     
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    
    
}



extension UniverseViewController {
    func configUICollectionView(cellId: String) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width , height: view.frame.size.height / 8)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        let nib = UINib(nibName: cellId, bundle: .main)
        collectionView?.register(nib, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView!)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
}

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//    }
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let myCell = cell as? CollectionViewCell else { return }
//        let element = self.universe!
//        myCell.name = "\(element.id)"
//        myCell.descriptionItem = element.smallDescription()
//    }
//
//
  

//}

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
