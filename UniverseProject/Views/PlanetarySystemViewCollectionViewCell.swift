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
    @IBOutlet weak var luminosityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var countOfPlanetsLabel: UILabel!
    
    weak var planetarySystem: PlanetarySystem? {
        didSet {
            let shortRepresentationDict = planetarySystem?.getBriefSystemRepresentation()
            let fullRepresentationDict = planetarySystem?.getFullSystemRespresentation()
            let shortStarRepresentationDict = planetarySystem?.star?.getBriefSystemRepresentation()
            let fullStarRepresentationDict = planetarySystem?.star?.getFullSystemRespresentation()
    
            planetarySystemId.text = shortRepresentationDict?["id"]
            starId.text = shortStarRepresentationDict?["id"]
            typeOfStar.text = fullStarRepresentationDict?["type"]
            evolutionStage.text = fullStarRepresentationDict?["stage"]
            weight.text = fullStarRepresentationDict?["weight"]
            radiusOfStar.text = fullStarRepresentationDict?["radius"]
            luminosityLabel.text = fullStarRepresentationDict?["luminosity"]
            temperatureLabel.text = fullStarRepresentationDict?["temperature"]
            countOfPlanetsLabel.text = fullRepresentationDict?["count of planets"]
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
