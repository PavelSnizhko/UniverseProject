//
//  CollectionViewCell.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var planetarySystemsCount: UILabel!
    
    
    var component: Compose? {
        didSet {
            if let galaxy = component as? Galaxy {
                idLabel.text = galaxy.id.uuidString
                typeLabel.text = galaxy.type.rawValue
                weightLabel.text = String(galaxy.countWeight())
                planetarySystemsCount.text = String(galaxy.componentsDict.count)
            }
            else if let universe = component as? Universe {
                idLabel.text = universe.id.uuidString
                typeLabel.text = "Universe"
                weightLabel.text = String(universe.countWeight())
                planetarySystemsCount.text = String(universe.componentsDict.count)
            }
            else {
                // maybe it is stupid or useful for prepareForReuse func 
                idLabel.text = nil
                typeLabel.text = nil
                weightLabel.text = nil
                planetarySystemsCount.text = nil
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .link
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        component = nil
    }
    
    
    
    
//    func update(component: Compose) {
//        self.name = component.smallDescription()
//        self.descriptionItem = component.showContent()
//        if let component = component as? Planet {
//            print(component.showContent())
//        }
//    }
        
}
