//
//  BlackHoleCollectionViewCell.swift
//  UniverseProject
//
//  Created by Павел Снижко on 06.02.2021.
//

import UIKit

class BlackHoleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var radiusLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    
    var blackHole: BlackHole? {
        didSet {
            let shortBlackHoleDescriptionDict = blackHole?.smallDescription()
            let fullBlackHoleDescription = blackHole?.showContent()
            idLabel.text = shortBlackHoleDescriptionDict?["id"]
            radiusLabel.text = fullBlackHoleDescription?["radius"]
            weightLabel.text = fullBlackHoleDescription?["weight"]
            ageLabel.text = fullBlackHoleDescription?["age"]
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        blackHole = nil
    }

}
