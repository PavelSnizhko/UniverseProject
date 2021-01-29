//
//  PlanetaryViewCell.swift
//  UniverseProject
//
//  Created by Павел Снижко on 28.01.2021.
//

import UIKit

class PlanetaryViewCell: UICollectionViewCell {

    @IBOutlet private weak var planetarySystemId: UILabel!
    @IBOutlet private weak var starInfo: UILabel!
    @IBOutlet private weak var planetInfo: UILabel!
    
    
    var id: String? {
        get {
            planetarySystemId.text
        }
        set {
            planetarySystemId.text = newValue
        }
    }
    
    var hostStar: String? {
        get {
            starInfo.text
        }
        set {
            starInfo.text = newValue
        }
    }
    
    var planetsDescription: String? {
        get {
            planetInfo.text
        }
        set {
            planetInfo.text = newValue
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        id = nil
        hostStar = nil
        planetsDescription = nil
    }
    
    
    func updatePlanetary(component: PlanetarySystem) {
        self.id = component.smallDescription()
        self.hostStar = component.star?.showContent()
        self.planetsDescription = component.showContent()
    }

}
