//
//  ModelGenerator.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation


class ModelGenerator: PowerModelGenerator {
        
    func generateBlackHole(star: Star) -> BlackHole {
        return BlackHole(id: star.id, weight: star.weight, radius: star.radius)
    }
    
   
    func generatePlanetarySystem(galaxyDelegat: Galaxy) -> Compose {
        let type = Star.StarType.allCases.randomElement()!
        return PlanetarySystem(id: UUID(), delegateModelGenerator: self, destroyingPlanetarySystemDelegate: galaxyDelegat, mainStar: Star(id: UUID(), weight: Int.random(in: 0..<100), type: type, temeperature: Int.random(in: 0..<100), luminosity: Int.random(in: 0..<100), radius: Int.random(in: 0..<100)))
    }
    
    func generatePlanet() -> Compose {
        let type = Planet.PlanetType.allCases.randomElement()!
        return Planet(weight: Int.random(in: 0..<100), componentsDict: generateStatelite(), type: type, delegate: self, id: UUID())
    }

    func generateStatelite() -> [UUID:Compose] {
        var statelites: [UUID:Compose] = [:]
        for _ in 0..<(Int.random(in: 0..<6)) {
            let type = Planet.PlanetType.allCases.randomElement()!
            let statelite = Planet(weight: Int.random(in: 0..<100), componentsDict: [:], type: type, delegate: nil, id: UUID())
            statelites[statelite.id] = statelite
        }
        return statelites
    }

    func generateGalaxy() -> Compose {
        let type = Galaxy.GalaxyType.allCases.randomElement()!
        return Galaxy(id: UUID(), type: type, delegate: self)
    }

    
    func createUniverse(reloadDataDelegate: ReloadDataDelegate?) -> Compose {
        let universe = Universe(id: UUID(), delegate: self, timePeriod: 10, universeRule: UniverseRule(radiusBoundary: 10, weightBoundary: 10),  reloadDataDelegate: reloadDataDelegate)
        return universe
    }
    
}
