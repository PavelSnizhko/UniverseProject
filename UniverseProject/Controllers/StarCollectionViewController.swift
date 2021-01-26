//
//  StarCollectionViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 22.01.2021.
//

import UIKit


class StarCollectionViewController: UICollectionViewController {


    var stars: [Compose] = []
    let cellId = String(describing: CollectionViewCell.self)


    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: cellId)

    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(stars.count)
        return stars.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }

    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? CollectionViewCell else { return }
        let element = stars[indexPath.row]
        myCell.name = "\(element.id)"
        myCell.descriptionItem = element.smallDescription()
    }
    
    //TODO I comment all 
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let star = self.stars.values[indexPath.row] as? Star {
//            print("Я в Star")
//            let planetCollectionVC = storyboard?.instantiateViewController(withIdentifier: "PlanetCollectionViewController") as! PlanetCollectionViewController
////            present(sb, animated: true, completion: nil)?
//            //TODO: change to private acces for array
//            planetCollectionVC.planets =
//            navigationController?.pushViewController(planetCollectionVC, animated: true)
//        }
//    }

}
