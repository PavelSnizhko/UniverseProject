//
//  ViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var data = [("Pasha", "1234567"), ("Dasha", "534534"), ("Sasha", "142343267")]
    let cellId = String(describing: CollectionViewCell.self)
    
//    private var collectionViewController: UICollectionViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
//        return vc
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: cellId)
       // Do any additional setup after loading the view.
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? CollectionViewCell else { return }
        myCell.name = data[indexPath.row].0
        myCell.descriptionItem = data[indexPath.row].1
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let data_ = self.data[indexPath.row]
//
//        navigationControler?.pushViewController(collectionViewController, animated: true)
//
//
//    }
    

    

}
