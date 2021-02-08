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
    var universe: Universe?
    let cellId = String(describing: CollectionViewCell.self)
    weak var timer: Timer?
    weak var galaxyViewController: GalaxyViewController?

    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUICollectionView(cellId: cellId)
        
        // change cast it was for working checking
        self.universe = self.modelGenerator.createUniverse(reloadDataDelegate: self) as? Universe

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
        myCell.component = component
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let universe = self.universe as? Universe {
            let galaxyVC = storyboard?.instantiateViewController(withIdentifier: "GalaxyViewController") as! GalaxyViewController
            galaxyViewController = galaxyVC
            galaxyVC.component = universe
            self.universe?.deleteComponentsDelegate = galaxyVC
            navigationController?.pushViewController(galaxyVC, animated: true)
            
//        }
    }
}

extension UniverseViewController: ReloadDataDelegate {
    
    func reloadData(component: Compose?) {
        //put nil to reloadData galaxyViewCotroller because I not adding anything
        self.galaxyViewController?.reloadData(component: component)
        
        self.collectionView?.reloadData()
        //тепер минулих не зможу загрузити походу...
    }
    
    
    
}



private extension UniverseViewController {
    func configUICollectionView(cellId: String) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width , height: view.frame.size.height / 4)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        let nib = UINib(nibName: cellId, bundle: .main)
        collectionView?.register(nib, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView!)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
}
