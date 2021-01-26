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
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(galaxies.count)
        return galaxies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }

//    TODO: I commented this to change later 
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let galaxy = self.galaxies[indexPath.row] as? Galaxy {
//            print("Я в galaxies")
//            let starCollectionVC = storyboard?.instantiateViewController(withIdentifier: "StarCollectionViewController") as? StarCollectionViewController
////            present(sb, animated: true, completion: nil)?
//            starCollectionVC!.stars = galaxy.contentArray
//            navigationController?.pushViewController(starCollectionVC!, animated: true)
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? CollectionViewCell else { return }
        let element = galaxies[indexPath.row]
        myCell.name = "\(element.id)"
        myCell.descriptionItem = element.smallDescription()
    }

}


