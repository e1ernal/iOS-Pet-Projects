//
//  WorkWithModel.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 14.07.2022.
//

import Foundation
import CoreData
import UIKit

var scores = [Score]()

// MARK: Work with CoreData
class ModelRequest {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func appendItem(score: Int, name: String, time: Int, date: Date) {
        let scoreObject = Score(context: context)
        scoreObject.score = Int64(score)
        scoreObject.name = name
        scoreObject.date = date
        scoreObject.time = Int64(time)
        
        do {
            try context.save()
            scores.append(scoreObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getAllItems() {
        do {
            scores = try context.fetch(Score.fetchRequest())
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllItems() {
        for score in scores {
            context.delete(score)
        }
        do {
            try context.save()
            scores.removeAll()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
