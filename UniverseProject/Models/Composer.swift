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
     Chaing of responsibility to arrive a time interval from timer to handler(branches and leafs in our tree)
    */
    var id: UInt32 { get }
    func smallDescription() -> String
    func showContent() -> String
    func handleTimePeriod() -> Bool
}
