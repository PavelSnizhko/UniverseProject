//
//  PlanetaryViewCell.swift
//  UniverseProject
//
//  Created by Павел Снижко on 28.01.2021.
//

import UIKit

class PlanetaryViewCell: UICollectionViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet private weak var type: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var countOfPlanetsLabel: UILabel!
    
    weak var component: Compose? {
        didSet {
            let shortRepresentationDict = component?.getBriefSystemRepresentation()
            let fullRepresentationDict = component?.getFullSystemRespresentation()
            idLabel.text = shortRepresentationDict?["id"]
            type.text = fullRepresentationDict?["type"]
            weightLabel.text = fullRepresentationDict?["weight"]
            countOfPlanetsLabel.text = fullRepresentationDict?["count of statelites"]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        component = nil
    }
}
