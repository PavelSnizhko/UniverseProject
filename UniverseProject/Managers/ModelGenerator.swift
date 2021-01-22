//
//  ModelGenerator.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation


class ModelGenerator: PowerModelGenerator {
    //?
    init() {
        
    }
    
    func generateModel(modelType: Compose) -> Compose {
        if modelType is Galaxy{
            let galaxy = generateGalaxy()
            galaxy.delegate = self
            return galaxy
        }
        else if  modelType is Star {
            let star = generateStar()
            star.delegate = self
            return star
        }
        else if  modelType is Planet {
            let planet = generatePlanet()
            planet.delegate = self
            return planet
        }
        // Clean that
        return Universe(name: "name")
    }
    
    func createUniverse() -> Compose {
        let universe = Universe(name: "New universe")
        universe.delegate = self
        return universe
    }
}
