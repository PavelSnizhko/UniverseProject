//
//  File.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//
import Foundation

protocol Compose {
    /*
     Implementation two patterns such as compositor pattern and chain of responsibility
     The universe system views like a tree that's why using compositor
     Chain of responsibility to arrive a time interval from timer to handler(branches and leafs in our tree)
    */
    var id: UUID { get }
    func countWeight() -> Int
    func smallDescription() -> String
    func showContent() -> String
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule)
    
}

