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
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var countOfNestedComponentsLabel: UILabel!
    var component: Compose? {
        didSet {
            let shortRepresentationDict = component?.smallDescription()
            let fullRepresentationDict = component?.showContent()
            idLabel.text = shortRepresentationDict?["id"]
            weightLabel.text = fullRepresentationDict?["weight"]
            countOfNestedComponentsLabel.text = fullRepresentationDict?["count of nested systems"]
            ageLabel.text = fullRepresentationDict?["age"]
            typeLabel.text = fullRepresentationDict?["type", default: "No clasification"]
            }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .link
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        component = nil
    }
            
}
