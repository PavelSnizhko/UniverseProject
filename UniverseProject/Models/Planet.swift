//
//  Planet.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

class Planet {
    enum PlanetType: String, CaseIterable {
        case iron = "Iron type of planet"
        case silicate = "Silicate type of planet "
        case carbon = " Carbon type of planet "
    }
    
    weak var delegate: GenerateViaDelegateProtocolSatellite?
    
    var id: UUID
    private(set) var type: PlanetType
    private(set) var weight: Int
    private(set) var age: Int = 0
    private(set) var componentsDict: [UUID : Compose] = [:]
    weak var reloadDelegate: ReloadDataDelegate?
        
    init(weight: Int, componentsDict: [UUID:Compose], type: PlanetType, delegate: GenerateViaDelegateProtocolSatellite?, id: UUID) {
        self.id = id
        self.weight = weight
        self.componentsDict = componentsDict
        self.type = type
        self.delegate = delegate
    }
    
    
    deinit {
        if componentsDict.isEmpty {
            print("Was deleted statelite")
        }
        else {
            print("Was deleted statelite planet")
        }
    }
}

extension Planet: Compose {
    
    func countWeight() -> Int {
        return componentsDict.values.reduce(0, { $0 + $1.countWeight() } )
    }
    

    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        print("Планета \(id.uuidString) прожила \(self.age)")
        self.reloadDelegate?.reloadData(component: nil)
    }
    
    func showContent() -> String {
        if componentsDict.isEmpty {
            return " \n Statelite \(id.uuidString + "\t" + type.rawValue + "\n") "
        }
        return "Planet \(id.uuidString ) has  " + componentsDict.values.reduce(" ", { result, component -> String in
            result + component.showContent()
        })
    }
    
    func smallDescription() -> String {
        return id.uuidString + "\t" + type.rawValue
    }
}
