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
    
    
    var blackHole: BlackHole? {
        didSet {
            idLabel.text = blackHole?.id.uuidString
            if let radius = blackHole?.radius{
                radiusLabel.text = String(radius)
            }
            else {
                radiusLabel.text = nil
            }
            if let weight = blackHole?.weight{
                radiusLabel.text = String(weight)
            }
            else {
                radiusLabel.text = nil
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        blackHole = nil
    }

}
