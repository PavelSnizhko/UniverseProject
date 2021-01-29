//
//  StarViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 28.01.2021.
//

import UIKit

class StarViewController: UIViewController {

        var hostStar: Compose?
    //    var planetaryKeys: [UUID]?
        let cellId = String(describing: CollectionViewCell.self)
        var collectionView: UICollectionView?

        override func viewDidLoad() {
            super.viewDidLoad()
            let nib = UINib(nibName: cellId, bundle: .main)
    //        self.planetaryKeys = Array(planetarySystems.keys)
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: view.frame.size.width , height: view.frame.size.height / 8)
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView?.backgroundColor = .white

            collectionView?.register(nib, forCellWithReuseIdentifier: cellId)
            view.addSubview(collectionView!)
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
        
        override func viewDidLayoutSubviews() {
            collectionView?.frame = view.bounds
        }
    }

extension StarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

        }
        
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            guard let myCell = cell as? CollectionViewCell else { return }
            if let component = hostStar {
                myCell.update(component: component)
            }
        }
        
}


extension StarViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        self.collectionView?.reloadData()
    }
    
    
}
