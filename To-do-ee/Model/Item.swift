//
//  Item.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 01/11/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated : Date?

    
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
