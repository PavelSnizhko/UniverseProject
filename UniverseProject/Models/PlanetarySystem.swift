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
    var id: UUID
    var age: Int = 0
    private(set) var star: Compose?
    private(set) var componentsDict: [UUID:Compose] = [:]
//    {
//        didSet {
//            DispatchQueue.main.async { [weak self] in
//                self?.reloadDelegate?.reloadData(component: nil)
//
//            }
//        }
//    }
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
    
    func smallDescription() -> String {
        return "\(id.uuidString)"
    }
    
    func showContent() -> String {
        guard let star = star else { return " The system is died"  }
        return "Host star \(star.id) Counts of planets \(componentsDict.count)"
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
        self.star = nil
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



