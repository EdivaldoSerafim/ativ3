//
//  UIViewController+Context.swift
//  ativ3
//
//  Created by Edivaldo Serafim on 07/09/21.
//  Copyright © 2021 Edivaldo Serafim. All rights reserved.
//


import UIKit
import CoreData

extension UIViewController{
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}


