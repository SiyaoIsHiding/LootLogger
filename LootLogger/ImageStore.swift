//
//  ImageStore.swift
//  LootLogger
//
//  Created by HE Siyao on 30/10/2022.
//

import UIKit


class ImageStore{
    let cache = NSCache<NSString, UIImage>()
    
    func imageURL(forKey key: String) -> URL{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectory.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(forKey: key)
        if let data = image.jpegData(compressionQuality: 0.5){
            try? data.write(to: url)
        }
    }
    
    func image(forKey key: String) -> UIImage?{
        if let existingImage = cache.object(forKey: key as NSString){
            return existingImage
        }
        
        guard let imageDisk = UIImage(contentsOfFile: imageURL(forKey: key).path) else {
            return nil
        }
        cache.setObject(imageDisk, forKey: key as NSString)
        return imageDisk
    }
    
    func removeImage(forKey key: String){
        cache.removeObject(forKey: key as NSString)
        do{
            try FileManager.default.removeItem(at: imageURL(forKey: key))
        }catch{
            print("Error removing image from disk: \(error)")
        }
    }
}
