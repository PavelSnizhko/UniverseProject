//
//  Star.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

protocol PosibleBlackHole: class {
    func changeStarToBlackHole(star: Star)
}



class Star {
    /*
     There is used componentsDict because around star can be rotated not only planet also some asteroids and comets.If we want to expend It will be very usefull
    */
    enum StarType: String, CaseIterable {
        case brownDwarfStar
        case redDwarfStar
        case blueGiantStar
        case redGiantStar
        case redSuperGiantStar
        case whiteDwarfStar
        case yellowDwarfStar
    }
    
    enum EvolutionStage: String {
        case young = "First evolution stage"
        case old = "Second evolution stage"
        case carlic = "Final evolution stage"
    }

    var id: UUID
    private(set) var type: StarType
    private(set) var age: Int = 0
    private(set) var weight: Int
    private(set) var tempterature: Int
    private(set) var luminosity: Int
    private(set) var radius: Int
    private(set) var evolutionStage: EvolutionStage
    private weak var blackHoleDelegate: PosibleBlackHole?
    private (set) var componentsDict: [UUID: Compose] = [:]
    weak var reloadDelegate: ReloadDataDelegate?
    
    
    init(id: UUID, weight: Int, type: StarType, temeperature: Int, luminosity: Int, radius: Int) {
        self.evolutionStage = .young
        self.type = type
        self.tempterature = temeperature
        self.luminosity = luminosity
        self.weight = weight
        self.radius = radius
        self.id = id
        print(" Star \(id)  will be the black hole \(self.weight > 50 && self.radius > 50 )")
    }
    
    deinit {
        print("|||____________ Star is deleted |||____________")

    }
    
}

extension Star: Compose {
    
    func setDelegate(blackHoleDelegate: PosibleBlackHole) -> Star {
        self.blackHoleDelegate = blackHoleDelegate
        return self
    }
    
    func countWeight() -> Int {
        self.weight
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        // think about return
        self.age += timeInterval
        if self.age % 60 == 0 {
            print("Міняється стан зірки")
            print("СТАН ЗВЕЗДЫ БЫЛ  \(self.evolutionStage.rawValue) ")
            if self.evolutionStage == EvolutionStage.young {
                self.evolutionStage = EvolutionStage.old
            }
            else if self.evolutionStage == EvolutionStage.old && self.weight >= universeRule.weightBoundary, self.radius >= universeRule.radiusBoundary {
                blackHoleDelegate?.changeStarToBlackHole(star: self)
            }
            else {
                self.evolutionStage = EvolutionStage.carlic
            }
            print("СТАН ЗВЕЗДЫ СТАЛ \(self.evolutionStage.rawValue)")
        }
    }
    

    
    func showContent() -> String {
        return  id.uuidString + type.rawValue + "\(self.age)" + evolutionStage.rawValue
    }
    
    func smallDescription() -> String {
        return id.uuidString + type.rawValue + "\(self.age)"
    }
    
}


class BlackHole: Compose {
    private(set) var id: UUID
    private(set) var age: Int = 0
    let radius: Int
    let weight: Int
    weak var reloadDelegate: ReloadDataDelegate?
    private(set) var componentsDict: [UUID : Compose] = [:]

    
    init(id: UUID, weight: Int, radius: Int) {
        self.id = id
        self.weight = weight
        self.radius = radius
        print(".............BlackHole is created..................................")
    }
    
    deinit {
        print("...........||| BlackHole is delete |||..................................")

    }
    
    
    func countWeight() -> Int {
        self.weight
    }
    
    func smallDescription() -> String {
        return id.uuidString + "I'm black hole"
    }
    
    func showContent() -> String {
        return "\(id) \t" +  "\(weight) \t" + "\(radius) \t"
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        print("Добавився час в Чорній дирі")
    }
    
   
}
