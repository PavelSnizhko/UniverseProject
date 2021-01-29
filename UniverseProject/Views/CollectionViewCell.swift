//
//  CollectionViewCell.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    
    var name: String? {
        get {
            nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var descriptionItem: String? {
        get {
            descriptionLabel.text
        }
        set {
            descriptionLabel.text = newValue
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .link
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name = nil
        descriptionItem = nil
    }
    
    func update(component: Compose) {
        self.name = component.smallDescription()
        self.descriptionItem = component.showContent()
    }
        
}
