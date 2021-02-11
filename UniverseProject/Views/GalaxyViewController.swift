//
//  GalaxyCollectionViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 22.01.2021.
//

import UIKit


protocol DeleteDataDelegate: class {
    //gonna delete data from galaxy it will be planetary system
    func deleteData(from component: Compose, planetarySystem: Compose?)
}


protocol DeleteComponentsDelegate: class {
    func deleteComponents(from component: Compose, components: (Compose, Compose))
}


class GalaxyViewController: UIViewController {

    weak var planetarySystemVC: PlanetarySystemViewController?
    weak var universe: Compose?
    private var galaxies: [Compose] = []
    let cellId = String(describing: CollectionViewCell.self)
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUICollectionView(cellId: cellId)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // set to nil when was invoked navigation controller and came on this view
        planetarySystemVC = nil
        initDataSourceArray()
    }
    
    func initDataSourceArray() {
        guard let components = self.universe?.getComponents() else { return }
        self.galaxies = components

    }
    
}

extension GalaxyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(galaxies.count)
        return galaxies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let myCell = cell as? CollectionViewCell else { return }
        guard let galaxy = self.galaxies[indexPath.row] as? Galaxy else { return }
        myCell.component = galaxy
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        planetarySystemVC = storyboard?.instantiateViewController(withIdentifier: "PlanetarySystemViewController") as? PlanetarySystemViewController
        guard let galaxy = self.galaxies[indexPath.row] as? Galaxy else { return }
        
//        planetarySystemVC?.planetarySystems = galaxy.getComponents()
        guard let planetarySystemVC = planetarySystemVC else { return }
        planetarySystemVC.galaxy = galaxy
        galaxy.reloadDelegate = planetarySystemVC
        galaxy.deleteDelegate = planetarySystemVC
        
        navigationController?.pushViewController(planetarySystemVC, animated: true)
    }
    
    
}

extension GalaxyViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        // the main idea if component nill then just update value in models view
        guard let galaxy = component else { self.collectionView?.reloadData(); return }
        self.galaxies.append(galaxy)
        self.planetarySystemVC?.reloadData(component: nil)
        self.collectionView?.reloadData()
    }
}
    



extension GalaxyViewController: DeleteDataDelegate, DeleteComponentsDelegate {

    func deleteComponents(from component: Compose, components: (Compose, Compose)) {
        // If I'm on planetarySystemVC show alert
        if (components.0.id == planetarySystemVC?.galaxy?.id || components.1.id == planetarySystemVC?.galaxy?.id), let planetarySystemVC = planetarySystemVC {
                    planetarySystemVC.cameBackToRootVC(from: planetarySystemVC, with: UIAlertController (title: "Go back to UniverseVC", message: "Probably, Galaxy was collided", preferredStyle: .alert))
                }
        self.galaxies.removeAll(where: { $0.id == components.0.id || $0.id == components.1.id } )
        self.collectionView?.reloadData()
    }
    
    // delete data when BlackHole appears
    func deleteData(from component: Compose, planetarySystem: Compose?) {
        if let planetarySystem = planetarySystem {
            // this condition for blackHole
            self.planetarySystemVC?.deletePlanetarySystem(component: planetarySystem)
        }
    }
}

    


extension GalaxyViewController {
    func configUICollectionView(cellId: String) {
        let nib = UINib(nibName: cellId, bundle: .main)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width , height: view.frame.size.height / 6)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white

        collectionView?.register(nib, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}
    
    

