//
//  Star.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation


class Star {
    /*
     There is used content array because around star can be rotated not only planet also some asteroids and comets.If we want to expend It will be very usefull
    */
    
    enum StarType: CaseIterable {
        case brownDwarfStar
        case redDwarfStar
        case blueGiantStar
        case redGiantStar
        case redSuperGiantStar
        case whiteDwarfStar
        case yellowDwarfStar
    }
    
    
    private enum EvolutionStage: String {
        case young = "First evolution stage"
        case old = "Second evolution stage"
        case final = "Final evolution stage"
    }
    
    weak var delegate: GenerateViaDelegateProtocolPlanet?
    var id = arc4random_uniform(100)
    var name: String
    private var type: StarType
    var weight: Int
    var tempterature: Int
    var luminosity: Int
    var radius: Int
    
    private var evolutionStage: EvolutionStage
    //TODO:  Create as private in the future 
    var contentArray = [Compose]()

    
    init(name: String, weight: Int, type: StarType, temeperature: Int, luminosity: Int, radius: Int, delegate: GenerateViaDelegateProtocolPlanet) {
        self.name = name
        self.evolutionStage = .young
        self.type = type
        self.tempterature = temeperature
        self.luminosity = luminosity
        self.weight = weight
        self.radius = radius
        self.delegate = delegate
//        self.delegate = delegate
    }
    
    func addComponent(component: Compose) {
        contentArray.append(component)
    }
    
    
}

extension Star: Compose {
    func handleTimePeriod(timeInterval: Int) {
        // think about return
        guard self.contentArray.count < 9 else { return }
        if let planet = self.delegate?.generatePlanet() {
            print(planet)
            self.contentArray.append(planet)
        }
    }
    
    func showContent() -> String {
        return name + evolutionStage.rawValue +  contentArray.reduce("", { $0 + $1.showContent()})
    }
    
    func smallDescription() -> String {
        return name
    }
}
