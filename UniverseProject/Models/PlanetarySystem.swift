//
//  planetarySystem.swift
//  UniverseProject
//
//  Created by Павел Снижко on 26.01.2021.
//

import Foundation


protocol DestroyPlanetarySystem: class {
    func destroyPlanetarySystem(id: UUID, blackHole: BlackHole)
}

typealias GenerateViaDelegateNewComponent = GenerateViaDelegateProtocolPlanet & GenerateViaDelegateProtocolBlackHole

class PlanetarySystem: Compose, PosibleBlackHole {
    
    // In this case can be make more then 1 star, but to simplify made for 1
    // contentArray naming due to there can be diff objects some commets for example
    private(set) var id: UUID
    private(set) var age: Int = 0
    private(set) var star: Compose?
    private(set) var componentsDict: [UUID:Compose] = [:]
    weak var delegateModelGenerator: GenerateViaDelegateNewComponent?
    weak var delegateDestroyPlanetarySystem: DestroyPlanetarySystem?
    weak var reloadDelegate: ReloadDataDelegate?
    weak var deleteDelegate: DeleteDataDelegate?


    
    init(id: UUID, delegateModelGenerator: ModelGenerator, delegateDestroyPlanetarySystem: Galaxy, mainStar: Star) {
        self.id = id
        self.star = mainStar.setDelegate(blackHoleDelegate: self)
        self.delegateModelGenerator = delegateModelGenerator
        self.delegateDestroyPlanetarySystem = delegateDestroyPlanetarySystem
    }
    
    func getBriefSystemRepresentation() -> [String: String] {
        return ["id": id.uuidString]
    }
    
    func getFullSystemRespresentation() -> [String: String] {
        //this guard return shouldn't be awoken just for avoid force unwrap
        guard let star = star else { return  ["state": "The system is died"] }
        return ["host star": star.id.uuidString, "count of planets": String(componentsDict.count), "weight": String(countWeight()), "age": String(age)]
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        if self.age % 10 == 0 && componentsDict.count < 9 {
            if let component = self.delegateModelGenerator?.generatePlanet() {
                componentsDict[component.id] = component
                self.reloadDelegate?.reloadData(component: component)
            }
        }
        self.reloadDelegate?.reloadData(component: nil)
        self.star?.handleTimePeriod(timeInterval: timeInterval, universeRule: universeRule)
    }
    
    
    func countWeight() -> Int {
        componentsDict.values.reduce(star?.countWeight() ?? 0, { $0 + $1.countWeight()})
    }
    
    func changeStarToBlackHole(star: Star) {
        guard let blackHole = self.delegateModelGenerator?.generateBlackHole(star: star) else { return }
        delegateDestroyPlanetarySystem?.destroyPlanetarySystem(id: self.id, blackHole: blackHole )
        print(" Black hole transparent to Galaxy")
    }
    
    
    deinit {
        print("_______Видалена планетарна система______")
    }
    
}


extension PlanetarySystem: Equatable {
    static func == (lhs: PlanetarySystem, rhs: PlanetarySystem) -> Bool {
        lhs.id == rhs.id
    }
}



