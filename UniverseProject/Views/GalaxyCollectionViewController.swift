//
//  GalaxyCollectionViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 22.01.2021.
//

import UIKit


class GalaxyViewController: UIViewController {

    var galaxies: [String : Compose] = [:]
    let cellId = String(describing: CollectionViewCell.self)
//    var data = [("Pasha", "1234567"), ("Dasha", "534534"), ("Sasha", "142343267")]
    
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: .main)
        
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
//        createTimer()
//        self.collectionView.reloadData()
       // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
}

extension GalaxyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(" Was here ")
        return galaxies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? CollectionViewCell else { return }
        let element = Array<Compose>(self.galaxies.values)[indexPath.row]
        print("fdsfsdfsdfsdfsdfsd")
        myCell.name = "\(element.id)"
        myCell.descriptionItem = "\(element.smallDescription())"
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let galaxy = self.galaxies.values[indexPath.row] as? Galaxy {
//            print("Я тут")
//            let starVC = storyboard?.instantiateViewController(withIdentifier: "StarViewController") as! StarViewController
////            present(sb, animated: true, completion: nil)?
////            galaxyCollectionVC.galaxies = universe.contentArray
//            navigationController?.pushViewController(starVC, animated: true)
//        }
//    }
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    /////
    
    
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let nib = UINib(nibName: cellId, bundle: .main)
//        self.collectionView.register(nib, forCellWithReuseIdentifier: cellId)
//    }
//
//
//}
//
//extension GalaxyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(galaxies.count)
//        return galaxies.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//    }
//
//
//
////    TODO: I commented this to change later
////    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        if let galaxy = self.galaxies[indexPath.row] as? Galaxy {
////            print("Я в galaxies")
////            let starCollectionVC = storyboard?.instantiateViewController(withIdentifier: "StarCollectionViewController") as? StarCollectionViewController
//////            present(sb, animated: true, completion: nil)?
////            starCollectionVC!.stars = galaxy.contentArray
////            navigationController?.pushViewController(starCollectionVC!, animated: true)
////        }
////    }
//
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let myCell = cell as? CollectionViewCell else { return }
//        let element = galaxies[indexPath.row]
//        myCell.name = "\(element.id)"
//        myCell.descriptionItem = element.smallDescription()
//    }
//}
