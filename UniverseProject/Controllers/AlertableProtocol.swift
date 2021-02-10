//
//  AlertableProtocol.swift
//  UniverseProject
//
//  Created by Павел Снижко on 09.02.2021.
//

import UIKit


protocol Alertable {
    func cameBackToRootVC(from controller: UIViewController, with alert: UIAlertController)
}

extension Alertable {

    func cameBackToRootVC(from controller: UIViewController, with alert: UIAlertController) {
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:{ [weak controller] (alertOKAction) in
            controller?.dismiss(animated: false, completion: nil)
            controller?.navigationController?.popToRootViewController(animated: true)
            print("Було викликано АЛЕРТ для повернення")
                    }))
        controller.present(alert, animated: true, completion: nil)
    }
    

}
