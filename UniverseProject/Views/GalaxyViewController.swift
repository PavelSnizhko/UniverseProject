//
//  GalaxyCollectionViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 22.01.2021.
//

import UIKit


protocol DeleteDataDelegate: class {
    func deleteData(deletedComponent: Compose)
}


class GalaxyViewController: UIViewController {

    weak var planetarySystemVC: PlanetarySystemViewController?
    var galaxies: [Compose] = []
    let cellId = String(describing: CollectionViewCell.self)
    var galaxyKeys: [UUID] = []

    
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: .main)
        let layout = UICollectionViewFlowLayout()
//        self.galaxyKeys = Array(galaxies.keys)
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
        guard let galaxy = self.galaxies[indexPath.row] as? Galaxy else { return }
//        galaxy.reloadDelegate = self
//        galaxy.deleteDelegate = self
        myCell.update(component: galaxy)
//        myCell.name = "\(element.id)"
//        myCell.descriptionItem = "\(element.smallDescription())"
    }
    
    
    func appendNewCell(compenent: Compose) {
        self.collectionView?.performBatchUpdates({
            let indexPath = IndexPath(row: self.galaxies.count, section: 0)
            self.galaxies.append(compenent)
            //add your object to data source first
            self.collectionView?.insertItems(at: [indexPath])
        }, completion: nil)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        planetarySystemVC = storyboard?.instantiateViewController(withIdentifier: "PlanetarySystemViewController") as? PlanetarySystemViewController
        guard let galaxy = self.galaxies[indexPath.row] as? Galaxy else { return }
        galaxy.reloadDelegate = self
        galaxy.deleteDelegate = self
        planetarySystemVC?.planetarySystems = galaxy.getComponents()
        guard let planetarySystemVC = planetarySystemVC else { return }
        planetarySystemVC.currentId = galaxy.id
        
        navigationController?.pushViewController(planetarySystemVC, animated: true)
    }
    
    
}

extension GalaxyViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        if let component = component {
            self.planetarySystemVC?.appendNewCell(compenent: component)
        }
        else {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView?.reloadData()
            }
       
        }
    }
}
    
extension GalaxyViewController: DeleteDataDelegate {
    func deleteData(deletedComponent: Compose) {
        if  deletedComponent.id == planetarySystemVC?.currentId {
            self.planetarySystemVC?.showAlert()
        }
        //probably I don't need this weak self
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
            
        }
        
    }
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
