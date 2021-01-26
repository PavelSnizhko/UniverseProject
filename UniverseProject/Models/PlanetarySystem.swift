//
//  planetarySystem.swift
//  UniverseProject
//
//  Created by Павел Снижко on 26.01.2021.
//

import Foundation


protocol DestroyPlanetarySystem: class {
    func destroyPlanetarySystem(id: String, blackHole: BlackHole)
}

typealias GenerateViaDelegateNewComponent = GenerateViaDelegateProtocolPlanet & GenerateViaDelegateProtocolBlackHole

class PlanetarySystem: Compose, PosibleBlackHole {
    
    // In this case can be make more then 1 star, but to simplify made for 1
    // contentArray naming due to there can be diff objects some commets for example
    var id: UUID
    var age: Int = 0
    var star: Compose?
    var contentArray: [String:Compose] = [:]
    weak var delegateModelGenerator: GenerateViaDelegateNewComponent?
    weak var delegateDestroyPlanetarySystem: DestroyPlanetarySystem?

    
    init(id: UUID, delegateModelGenerator: ModelGenerator, delegateDestroyPlanetarySystem: Galaxy, mainStar: Star) {
        self.id = id
        self.delegateModelGenerator = delegateModelGenerator
        self.delegateDestroyPlanetarySystem = delegateDestroyPlanetarySystem
        
    }
    
    func smallDescription() -> String {
        return id.uuidString
    }
    
    func showContent() -> String {
        return id.uuidString
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        if self.age % 10 == 0 && contentArray.count < 9 {
            if let component = self.delegateModelGenerator?.generatePlanet() {
                contentArray[component.id.uuidString] = component
            }
        }
        if self.age % 60 == 0 {
            self.star?.handleTimePeriod(timeInterval: timeInterval, universeRule: universeRule)
        }
    }
    
    
    func countWeight() -> Int {
        contentArray.values.reduce(star?.countWeight() ?? 0, { $0 + $1.countWeight()})
    }
    
    func changeStarToBlackHole(star: Star) {
        guard let blackHole = self.delegateModelGenerator?.generateBlackHole(star: star) else { return }
        print("Black Hole" + blackHole.id.uuidString)
        self.star = blackHole
        delegateDestroyPlanetarySystem?.destroyPlanetarySystem(id: self.id.uuidString, blackHole: blackHole )
        print(" Black hole transparent to Galaxy")
    }
    
    
}

