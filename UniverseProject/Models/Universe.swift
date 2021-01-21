//
//  Universe.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

class Universe {
    var id: UInt32 = arc4random_uniform(100)
    var name: String
    private var contentArray = [Compose]()

    weak var delegate: GenerateViaDelegateProtocolGalaxy? {
        get {
            self.delegate
        }
        set {
            self.delegate = newValue
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func addComponent(component: Compose) {
        contentArray.append(component)
    }
}

extension Universe: Compose {
    func handleTimePeriod() -> Bool {
        true
    }
    
    func showContent() -> String {
        print("Was was here ")
        return contentArray.reduce(" ", { $0 + $1.showContent()})
    }
    
    func smallDescription() -> String {
        return name
    }
}
