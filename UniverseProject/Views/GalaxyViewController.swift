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
    weak var component: Compose?
    var galaxies: [Compose] {
        self.component?.getComponents() ?? []

    }
    let cellId = String(describing: CollectionViewCell.self)
    var galaxyKeys: [UUID] = []
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUICollectionView(cellId: cellId)

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
        myCell.update(component: galaxy)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        planetarySystemVC = storyboard?.instantiateViewController(withIdentifier: "PlanetarySystemViewController") as? PlanetarySystemViewController
        guard let galaxy = self.galaxies[indexPath.row] as? Galaxy else { return }
        galaxy.reloadDelegate = self
        galaxy.deleteDelegate = self
//        planetarySystemVC?.planetarySystems = galaxy.getComponents()
        guard let planetarySystemVC = planetarySystemVC else { return }
        planetarySystemVC.component = galaxy
        
        navigationController?.pushViewController(planetarySystemVC, animated: true)
    }
    
    
}

extension GalaxyViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        self.collectionView?.reloadData()
    }
}
    
extension GalaxyViewController: DeleteDataDelegate {
    func deleteData(deletedComponent: Compose) {
        print(" \(deletedComponent.id) == \(planetarySystemVC?.component?.id) ")
        if  deletedComponent.id == planetarySystemVC?.component?.id {
            self.planetarySystemVC?.showAlert()
        }
    }
}
    


extension GalaxyViewController {
    func configUICollectionView(cellId: String) {
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
}
    
    

