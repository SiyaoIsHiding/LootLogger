//
//  ItemStore.swift
//  LootLogger
//
//  Created by HE Siyao on 20/10/2022.
//

import UIKit

class ItemStore{
    var allItems = [Item]()
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    init(){
        // load data
        
        do{
            let data = try Data(contentsOf: itemArchiveURL)
            let decoder = PropertyListDecoder()
            let items = try decoder.decode([Item].self, from: data)
            allItems = items
        }catch{
            print("Error loading data: \(error)")
        }
        let notificationCenter  = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
    @discardableResult func createItem() -> Item{
        let newItem = Item()
        allItems.append(newItem)
        return newItem
    }
    
    
    func removeItem(_ index: Int){
        allItems.remove(at: index)
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
    @objc func saveChanges() -> Bool {
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allItems)
            try data.write(to: itemArchiveURL, options: .atomic)
            print("Save items data success to \(itemArchiveURL)")
            return true
        }catch let encodingError{
            print("Error encoding data: \(encodingError)")
            return false
        }
        
        
    }
}
