//
//  Galaxy.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

enum ComparableError: Error {
    case nillException
}

class Galaxy {
    /*
    There is used contentArray because if in our galaxy will be something another than Planet system it would be useful also it's smth like open close princeple
    */

    weak var delegate: GenerateViaDelegateProtocolStar? {
        get {
            self.delegate
        }
        set {
            self.delegate = newValue
        }
    }
    
    enum GalaxyType: CaseIterable {
        case eliptical
        case irregular
        case spiral
    }

    
    //TODO: Think about id
    var id: UInt32 = arc4random_uniform(100)
    var name: String
    var type: GalaxyType
    private var age: Int = 0
    private var weight: Int = 0
    private var contentArray = [Compose]()

    
    init(name: String, type: GalaxyType, age: Int = 0) {
        self.name = name
        self.type = type
        self.age = age
    }
    
    func increaseWeight(weight: Int) {
        self.weight += weight
    }
    
    
    func addComponent(component: Compose) {
        contentArray.append(component)
    }
    
    
     func increaeAge(age: Int = 10){
        self.age += age
    }
    
    func interact(with galaxy: Galaxy) -> Galaxy {
        let galaxy = Galaxy(name: "Galaxy after interection", type: .eliptical)
        galaxy.delegate = self.delegate
        return galaxy
    }

}


extension Galaxy: Comparable, Compose {

    func handleTimePeriod() -> Bool {
        true
    }
    
    static func < (lhs: Galaxy, rhs: Galaxy) -> Bool {
        return lhs.weight < lhs.weight
    }
    
    static func == (lhs: Galaxy, rhs: Galaxy) -> Bool {
        lhs.weight == rhs.weight
    }
    
    func showContent() -> String {
        return contentArray.reduce("", { $0 + $1.showContent()})
    }
    
    func smallDescription() -> String {
        return name
    }
    
}
