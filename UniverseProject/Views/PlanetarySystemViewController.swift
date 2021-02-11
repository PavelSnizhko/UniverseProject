//
//  PlanetarySystemViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 28.01.2021.
//

import UIKit

class PlanetarySystemViewController: UIViewController, Alertable {
    var currentId: UUID?
    weak var planetViewController: PlanetViewController?
    weak var galaxy: Compose?
    private var planetarySystems: [Compose] = []
    let planetarySystemCellId = String(describing: PlanetarySystemViewCollectionViewCell.self)
    let blackHoleCellId = String(describing: BlackHoleCollectionViewCell.self)
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // nil for good working of deleteDataDelegate
        planetViewController = nil
        initDataSourceArray()
    }
    
    func initDataSourceArray() {
        guard let components = self.galaxy?.getComponents() else { return }
        self.planetarySystems = components
    }
}

extension PlanetarySystemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetarySystems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // bad refactor it PLEASE!!!
        if (planetarySystems[indexPath.row] as? PlanetarySystem) != nil {
            return collectionView.dequeueReusableCell(withReuseIdentifier: planetarySystemCellId, for: indexPath)
        }
        else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: blackHoleCellId, for: indexPath)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell.reuseIdentifier == blackHoleCellId,let cell = cell as? BlackHoleCollectionViewCell, let blackHole = planetarySystems[indexPath.row] as? BlackHole {
            cell.blackHole = blackHole
        }
        else if cell.reuseIdentifier == planetarySystemCellId,let cell = cell as? PlanetarySystemViewCollectionViewCell, let planetarySystem = planetarySystems[indexPath.row] as? PlanetarySystem {
            cell.planetarySystem = planetarySystem
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        planetViewController = storyboard?.instantiateViewController(withIdentifier: "PlanetViewController") as? PlanetViewController
        guard let component = self.planetarySystems[indexPath.row] as? PlanetarySystem else { return }
        planetViewController?.component = component
        guard let planetVC = planetViewController else { return }
        component.reloadDelegate = planetVC
        
        navigationController?.pushViewController(planetVC, animated: true)
    }
}


private extension PlanetarySystemViewController {
    func configUI() {
        let planetaryCellNib = UINib(nibName: planetarySystemCellId, bundle: .main)
        let balckHoleCellNib = UINib(nibName: blackHoleCellId, bundle: .main)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width , height: view.frame.size.height / 4)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.register(planetaryCellNib, forCellWithReuseIdentifier: planetarySystemCellId)
        collectionView?.register(balckHoleCellNib, forCellWithReuseIdentifier: blackHoleCellId)

        view.addSubview(collectionView!)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}



extension PlanetarySystemViewController: ReloadDataDelegate, DeleteDataDelegate {
    func deleteData(from component: Compose, planetarySystem: Compose?) {
        //from component don't need anymore
        guard let tempComponent = planetarySystem else { return }
        self.deletePlanetarySystem(component: tempComponent)
    }
    
    
    func reloadData(component: Compose?) {
        // adding new ellement when it is being created in models
        guard let planetarySystem = component else { self.collectionView?.reloadData(); return }

        //possible move to some storege bacause it is not their work to do that...
        self.planetarySystems.append(planetarySystem)
        let indexPath = IndexPath(row: self.planetarySystems.count - 1, section: 0)
        self.collectionView?.performBatchUpdates({ self.collectionView?.insertItems(at: [indexPath]) }) { (finished) in
            self.collectionView?.reloadItems(at: self.collectionView!.indexPathsForVisibleItems)
        }
        self.collectionView?.layoutIfNeeded()
        // if planetViewController isn't nil then update next vc
        self.planetViewController?.reloadData(component: nil)
    }
    

    func deletePlanetarySystem(component: Compose) {
        // maybe not bad algorithm because older systems will be higher in the array and return statement reduce complexity
        // scenario if I view planetViewController
        for (index, planetarySystem) in planetarySystems.enumerated() {
            if  component.id == planetViewController?.component?.id, let planetViewController = planetViewController {
                planetViewController.cameBackToRootVC(from: planetViewController, with: UIAlertController (title: "Go back to Universe View Controller", message: "There was created Black Hole", preferredStyle: .alert))
            }
            
            if component == planetarySystem {
                self.planetarySystems.remove(at: index)
                let indexPath = IndexPath(row: index, section: 0)
                self.collectionView?.performBatchUpdates({ self.collectionView?.deleteItems(at: [indexPath]) }) { (finished) in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.collectionView?.reloadItems(at: self.collectionView!.indexPathsForVisibleItems)
                    }
                }
                return
            }
        }
    }
    
    func deleteData(from component: Compose) {
        if  component.id == planetViewController?.component?.id, let planetViewController = self.planetViewController {
            planetViewController.cameBackToRootVC(from: planetViewController, with: UIAlertController (title: "Go back to Universe View Controller", message: "There was created Black Hole", preferredStyle: .alert))        }
    }
}



