//
//  PlanetarySystemViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 28.01.2021.
//

import UIKit

class PlanetarySystemViewController: UIViewController {
    var currentId: UUID?
    weak var planetViewController: PlanetViewController?
    var planetarySystems: [Compose] = []
//    var planetaryKeys: [UUID]?
    let cellId = String(describing: PlanetaryViewCell.self)
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: .main)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height / 8)
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

extension PlanetarySystemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetarySystems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? PlanetaryViewCell, let planetarySystem = planetarySystems[indexPath.row] as? PlanetarySystem  else { return }
        planetarySystem.reloadDelegate = self
        myCell.updatePlanetary(component: planetarySystem)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        planetViewController = storyboard?.instantiateViewController(withIdentifier: "PlanetViewController") as? PlanetViewController
        let component = self.planetarySystems[indexPath.row]
        planetViewController?.planets = component.getComponents()
        guard let planetVC = planetViewController else { return }
        navigationController?.pushViewController(planetVC, animated: true)
    }
    
   
    
}


extension PlanetarySystemViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        if let component = component {
            if planetViewController?.planetId == component.id {
                planetViewController?.showAlert()
            }
        }
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    
    
    
}


extension PlanetarySystemViewController {
    
    func appendNewCell(compenent: Compose) {
        print("Нові дані")
            self.collectionView?.performBatchUpdates({
                let indexPath = IndexPath(row: self.planetarySystems.count, section: 0)
                self.planetarySystems.append(compenent)
                //add your object to data source first
                self.collectionView?.insertItems(at: [indexPath])
            }, completion: nil)
        
    }
    
    
    
    func showAlert() {

        let alert = UIAlertController (title: "Go back", message: "Maybe, Galaxy is collided or was created Black Hole", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:{ [weak self] (alertOKAction) in
            self?.popThisView()
            print("Було викликано АЛЕРТ для повернення")
                    }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func popThisView() {
        self.dismiss(animated: false, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }


    

}
