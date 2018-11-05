//
//  Category.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 01/11/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name = ""
    
    let items = List<Item>()
}
