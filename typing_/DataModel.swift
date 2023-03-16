//
//  DataModel.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 13/3/2023.
//

import Foundation
import RealmSwift

class DataModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var recordDate: Date = Date()
    @objc dynamic var sides: String = String()
    @objc dynamic var accuracy: Int = Int()
    @objc dynamic var speed: Int = Int()
}
