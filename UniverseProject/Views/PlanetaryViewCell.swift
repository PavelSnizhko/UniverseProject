//
//  PlanetaryViewCell.swift
//  UniverseProject
//
//  Created by Павел Снижко on 28.01.2021.
//

import UIKit

class PlanetaryViewCell: UICollectionViewCell {

    @IBOutlet private weak var type: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var countOfPlanetsLabel: UILabel!
    
    var planet: Planet? {
        didSet {
            type.text = planet?.type.rawValue
            weightLabel.text = String(planet?.weight ?? 0)
            countOfPlanetsLabel.text = String(planet?.componentsDict.count ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        planet = nil
    }
}
