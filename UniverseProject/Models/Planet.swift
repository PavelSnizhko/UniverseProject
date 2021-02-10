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
    
    private(set) var id: UUID
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
            print("maybe was deleted statelite or planet with 0 statelites")
        }
        else {
            print("Was deleted  planet")
        }
    }
}

extension Planet: Compose {
    
    func countWeight() -> Int {
        return componentsDict.values.reduce(0, { $0 + $1.countWeight() } )
    }
    

    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        //TODO: check this - do I realy need this reloadData ???
        self.reloadDelegate?.reloadData(component: nil)
    }
    
    func getFullSystemRespresentation() -> [String: String] {
        return  ["type": type.rawValue, "age": String(age), "weight": String(weight), "count of statelites": String(componentsDict.count)]
    }
    
    func getBriefSystemRepresentation() -> [String: String] {
        return ["id": id.uuidString]
    }
}
