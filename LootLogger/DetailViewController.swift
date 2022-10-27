//
//  DetailViewController.swift
//  LootLogger
//
//  Created by HE Siyao on 25/10/2022.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ _ in
            print("present camera")
        }
        alertController.addAction(cameraAction)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){ _ in
            print("present photo library")
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
    }
    
    let numberFormatter : NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        return f
    }()
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()
    
    var item: Item! {
        didSet{
            navigationItem.title = item.name
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.value))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        if let valueText = valueField.text, let valueInt = numberFormatter.number(from: valueText){
            item.value = valueInt.intValue
        }else{
            item.value = 0
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
