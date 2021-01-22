//
//  ModelGenerator.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation


class ModelGenerator: PowerModelGenerator {
    
    func generateStar() -> Compose {
        let type = Star.StarType.allCases.randomElement()!
        return Star(name: "New Star", weight: Int.random(in: 0..<100), type: type, temeperature: Int.random(in: 0..<100), luminosity: Int.random(in: 0..<100), radius: Int.random(in: 0..<100), delegate: self)
    }
    
    func generatePlanet() -> Compose {
        let type = Planet.PlanetType.allCases.randomElement()!
        return Planet(name: "New Planet + \(type)", weight: Int.random(in: 0..<100), satelliteArray: generateStatelite(), type: type, delegate: self)
    }

    func generateStatelite() -> [Compose] {
        var statelites: [Compose] = []
        for _ in 0..<(Int.random(in: 0..<6)) {
            let type = Planet.PlanetType.allCases.randomElement()!
            statelites.append(Planet(name: "New Planet + \(type)", weight: Int.random(in: 0..<100), satelliteArray: [], type: type, delegate: self))
        }
        return statelites
    }

    func generateGalaxy() -> Compose {
        print("Was created new Galaxy")
        let type = Galaxy.GalaxyType.allCases.randomElement()!
        return Galaxy(name: "New Galaxy + \(type)", type: type, delegate: self)
    }

    
//    func generateModel(modelType: Compose) -> Compose {
//        if modelType is Galaxy{
//            let galaxy = generateGalaxy()
//            galaxy.delegate = self
//            return galaxy
//        }
//        else if  modelType is Star {
//            let star = generateStar()
//            star.delegate = self
//            return star
//        }
//        else if  modelType is Planet {
//            let planet = generatePlanet()
//            planet.delegate = self
//            return planet
//        }
//        // Clean that
//        return Universe(name: "name")
//    }
    
    func createUniverse() -> Compose {
        let universe = Universe(name: "Single Universe", delegate: self)
        return universe
    }
}
