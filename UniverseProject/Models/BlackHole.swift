//
//  BlackHole.swift
//  UniverseProject
//
//  Created by Павел Снижко on 09.02.2021.
//

import Foundation


class BlackHole: Compose {
    private(set) var id: UUID
    private(set) var age: Int = 0
    private let radius: Int
    private let weight: Int
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
    
    func getBriefSystemRepresentation() -> [String: String] {
        return ["id": id.uuidString]
    }
    
    func getFullSystemRespresentation() -> [String: String] {
        return ["weight": String(countWeight()), "radius": String(radius), "age": String(age) ]
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
    }
    
   
}
