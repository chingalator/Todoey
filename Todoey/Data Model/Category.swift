//
//  Category.swift
//  Todoey
//
//  Created by Charles Tibbels on 4/14/18.
//  Copyright © 2018 invescity. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
