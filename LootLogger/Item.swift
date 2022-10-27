//
//  Item.swift
//  LootLogger
//
//  Created by HE Siyao on 20/10/2022.
//
import UIKit

class Item: Codable{
    var name: String
    var value: Int
    var serialNumber: String?
    let dateCreated: Date
    
    init(name: String, value: Int, serialNumber: String?){
        self.name = name
        self.value = value
        self.serialNumber = serialNumber
        self.dateCreated = Date()
    }
    
    convenience init(){
        
        let value = Int.random(in: 0..<100)
        let name = "name \(value)"
        let serialNumber = UUID().uuidString.components(separatedBy: "-").first!
        
        self.init(name: name, value: value, serialNumber: serialNumber)
        
        
    }
}
