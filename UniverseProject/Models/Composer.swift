//
//  File.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//
import Foundation

protocol Compose: class {
    /*
     Implementation two patterns such as compositor pattern and chain of responsibility
     The universe system views like a tree that's why using compositor
     Chain of responsibility to arrive a time interval from timer to handler(branches and leafs in our tree)
    */
    var id: UUID { get }
    var age: Int { get } 
    var componentsDict: [UUID: Compose] { get }
    var reloadDelegate: ReloadDataDelegate? { get set }
    func countWeight() -> Int
    func smallDescription() -> [String: String]
    func showContent() -> [String: String]
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule)
}


extension Compose {
    func getComponents () -> [Compose] {
        return componentsDict.values.sorted { $0.age > $1.age }
    }
        
    
}

func ==(lhs: Compose, rhs: Compose) -> Bool {
    guard type(of: lhs) == type(of: rhs) else { return false }
    return lhs.id == rhs.id
}



