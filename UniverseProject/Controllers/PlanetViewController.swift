//
//  PlanetCollectionViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 22.01.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class PlanetViewController: UIViewController {
    
    var planetaryId: UUID?
    weak var component: Compose?
    private var planets: [Compose] = []
    
//    {
//        component?.getComponents() ?? []
//    }

    let cellId = String(describing: PlanetaryViewCell.self)
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
        initDataSourceArray()
    }
    
    func initDataSourceArray() {
        guard let components = self.component?.getComponents() else { return }
        self.planets = components
    }
}


extension PlanetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? PlanetaryViewCell else { return }
        guard let planet = self.planets[indexPath.row] as? Planet else { return }
        myCell.planet = planet
    }

}


private extension PlanetViewController {
    func configUI() {
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
    }
}




extension PlanetViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        guard let planet = component else { self.collectionView?.reloadData(); return }
        self.planets.append(planet)
        self.collectionView?.reloadData()
    }
}


extension PlanetViewController {
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
        self.navigationController!.popToRootViewController(animated: true)
    }
}

