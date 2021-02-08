//
//  PlanetarySystemViewCollectionViewCell.swift
//  UniverseProject
//
//  Created by Павел Снижко on 06.02.2021.
//

import UIKit

class PlanetarySystemViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var planetarySystemId: UILabel!
    @IBOutlet weak var starId: UILabel!
    @IBOutlet weak var typeOfStar: UILabel!
    @IBOutlet weak var evolutionStage: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var radiusOfStar: UILabel!
    @IBOutlet weak var countsOfPlanets: UILabel!
    
    var planetarySystem: PlanetarySystem? {
        didSet {
            guard let planetarySystem = planetarySystem else {
                planetarySystemId.text = ""
                starId.text = ""
                typeOfStar.text = ""
                evolutionStage.text = ""
                weight.text = ""
                radiusOfStar.text = ""
                return
            }
            planetarySystemId.text = planetarySystem.id.uuidString
            if let star = planetarySystem.star as? Star {
                starId.text = star.id.uuidString
                typeOfStar.text = star.type.rawValue
                evolutionStage.text = star.evolutionStage.rawValue
                weight.text = String(star.weight)
                radiusOfStar.text = String(star.radius)
            }
            countsOfPlanets.text = String(planetarySystem.componentsDict.count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    
    override func prepareForReuse() {
        planetarySystem = nil
    }
    
}
