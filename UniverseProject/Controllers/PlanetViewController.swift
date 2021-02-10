//
//  PlanetCollectionViewController.swift
//  UniverseProject
//
//  Created by Павел Снижко on 22.01.2021.
//

import UIKit

class PlanetViewController: UIViewController, Alertable {
    
    weak var component: Compose?
    private let cellId = String(describing: PlanetaryViewCell.self)
    private var collectionView: UICollectionView?
    private var dataSource: PlanetDataSource?
    private var dataDelegate: PlanetDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        guard let component = component else { return }
        configInitCollectionViewData(component: component)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}


private extension PlanetViewController {
    func configUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width , height: view.frame.size.height / 8)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        view.addSubview(collectionView!)
        collectionView?.frame = view.bounds
    }
    
    
    func configInitCollectionViewData(component: Compose) {
        let nib = UINib(nibName: cellId, bundle: .main)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: cellId)
        self.dataDelegate = PlanetDelegate()
        self.dataSource = PlanetDataSource(component: component, collectionDataDelegate: dataDelegate)
        
        self.collectionView?.dataSource = dataSource
        self.collectionView?.delegate = dataDelegate
    }
    
}




extension PlanetViewController: ReloadDataDelegate {
    func reloadData(component: Compose?) {
        // delte and use method from datasource
        dataSource?.updateComponents(component: component)
        self.collectionView?.reloadData()
    }
}


protocol DataTransferable: class {
    func transfer(component: Compose)
}


class PlanetDataSource: NSObject {
    private weak var collectionDataDelegate: DataTransferable?
    private weak var component: Compose?
    private var components: [Compose]
    private let cellId = String(describing: PlanetaryViewCell.self)
    
    
    init(component: Compose?, collectionDataDelegate: DataTransferable?) {
        self.component = component
        self.components = component?.getComponents() ?? []
        self.collectionDataDelegate = collectionDataDelegate
    }
    
    func updateComponents(component: Compose?) {
        guard let component = component else {  return }
        self.components.append(component)
    }
    
    func getComponentId() -> UUID? {
        return component?.id
    }
    
    

}

extension PlanetDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return components.count
    }
    
    //todo make as static property reuse identifier for Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionDataDelegate?.transfer(component:self.components[indexPath.row] )
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlanetaryViewCell.self), for: indexPath)

    }
}



class PlanetDelegate: NSObject, UICollectionViewDelegate, DataTransferable {
    private var component: Compose?
    
    func transfer(component: Compose) {
        self.component = component
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let myCell = cell as? PlanetaryViewCell else { return }
        myCell.component = self.component
    }
}
