//
//  Item.swift
//  LocalStorage
//
//  Created by Dheeraj Verma on 17/07/21.
//

import Foundation

class Item: Codable {
    internal init(title: String? = nil, done: Bool? = false) {
        self.title = title
        self.done =  done
    }
    
    var title: String?
    var done: Bool?
}
