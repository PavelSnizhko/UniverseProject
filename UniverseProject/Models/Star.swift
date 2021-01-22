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
    
    weak var delegate: GenerateViaDelegateProtocolPlanet? {
        get {
            self.delegate
        }
        set {
            self.delegate = newValue
        }
    }
    var id = arc4random_uniform(100)
    var name: String
    private var type: StarType
    var weight: Int
    var tempterature: Int
    var luminosity: Int
    var radius: Int
    
    private var evolutionStage: EvolutionStage
    private var contentArray = [Compose]()

    
    init(name: String, weight: Int, type: StarType, temeperature: Int, luminosity: Int, radius: Int) {
        self.name = name
        self.evolutionStage = .young
        self.type = type
        self.tempterature = temeperature
        self.luminosity = luminosity
        self.weight = weight
        self.radius = radius
//        self.delegate = delegate
    }
    
    func addComponent(component: Compose) {
        contentArray.append(component)
    }
    
    
}

extension Star: Compose {
    func handleTimePeriod(timeInterval: Int) {
        for item in contentArray {
            item.handleTimePeriod(timeInterval: timeInterval)
        }
    }
    
    func showContent() -> String {
        return name + evolutionStage.rawValue +  contentArray.reduce("", { $0 + $1.showContent()})
    }
    
    func smallDescription() -> String {
        return name
    }
}
