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


//TODO: реалізація сповіщенян про додавання новго елемента завдяки делегату а lazy var щоб отримати данні

// Think abo

class GalaxyViewController: UIViewController {

    weak var planetarySystemVC: PlanetarySystemViewController?
    weak var component: Compose?
    private var galaxies: [Compose] = []
    let cellId = String(describing: CollectionViewCell.self)
    private var galaxyKeys: [UUID] = []
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
        guard let components = self.component?.getComponents() else { return }
        self.galaxies = components

    }
    
}

extension GalaxyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        planetarySystemVC.component = galaxy
        galaxy.reloadDelegate = planetarySystemVC
        galaxy.deleteDelegate = planetarySystemVC
        
        navigationController?.pushViewController(planetarySystemVC, animated: true)
    }
    
    
}

extension GalaxyViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        guard let galaxy = component else { self.collectionView?.reloadData(); return }
//        self.dataSource.update(galaxy)
        self.galaxies.append(galaxy)
        // Можливо звідси треба викликати щоб все добре оновлювалось
        self.planetarySystemVC?.reloadData(component: nil)
        self.collectionView?.reloadData()
    }
}
    



extension GalaxyViewController: DeleteDataDelegate, DeleteComponentsDelegate {

    //VERY BAD SOLUTION WHAT AM GONNA DO!!!!!!!!!!!!!!!!!!!!!
    func deleteComponents(from component: Compose, components: (Compose, Compose)) {
        for (index, galaxy) in galaxies.enumerated() {
            if components.0 == galaxy || components.1 == galaxy {
                
                self.galaxies.remove(at: index)
                let indexPath = IndexPath(row: index, section: 0)
                DispatchQueue.main.async {
                    self.collectionView?.performBatchUpdates({
                        self.collectionView?.deleteItems(at: [indexPath])
                        }) { (finished) in
                        self.collectionView?.reloadItems(at: self.collectionView!.indexPathsForVisibleItems)
                    }
                }
                // scenario if I'am on planetarySystemVC
                if galaxy.id == planetarySystemVC?.component?.id, let planetarySystemVC = planetarySystemVC {
                    // this condition for collision
                    planetarySystemVC.cameBackToRootVC(from: planetarySystemVC, with: UIAlertController (title: "Go back to UniverseVC", message: "Probably, Galaxy was collided", preferredStyle: .alert))
                }
                print("зараз видалю -()-" + galaxy.id.uuidString)
                
               
            }
        }
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
    
    

