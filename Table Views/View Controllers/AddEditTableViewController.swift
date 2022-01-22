//
//  AddEditTableViewController.swift
//  AddEditTableViewController
//
//  Created by Евгений Пашко on 01.11.2021.
//


import UIKit

class AddEditTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usage: UITextField!
    @IBOutlet weak var buttonSave: UIBarButtonItem!
    
    
    // MARK: - Properties
    var emoji = EmojiModel()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide button Save
        buttonSave.isEnabled = false
        updateUI()
    }
    
    
    // MARK: - Private Methods
    //Check all TextField isEmpty
    private func checkTextField() -> Bool {
        !(symbolTextField.text!.isEmpty ||
          nameTextField.text!.isEmpty ||
          descriptionTextField.text!.isEmpty ||
          usage.text!.isEmpty)
    }
    
    private func saveEmoji() {
        emoji.symbol = symbolTextField.text ?? ""
        emoji.name = nameTextField.text ?? ""
        emoji.description = descriptionTextField.text ?? ""
        emoji.usege = usage.text ?? ""
    }
    
    // Show alert message
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "I realized", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func updateUI() {
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
        usage.text = emoji.usege
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#line, #function, segue.identifier ?? "nil")
        saveEmoji()
    }
    
    
    // MARK: - IBActions
    @IBAction func textFieldChanged(_ sender: UITextField) {
        // Check Identifier
        if sender.restorationIdentifier == "emoji" {
            //https://developer.apple.com/documentation/swift/unicode/scalar/properties/3081577-isemoji
            
            //Convert sring to UnicodeScalars
            let string = sender.text!.unicodeScalars
            // Get current symbol from UITextField
            let lastString = sender.text!.dropLast()
            
            for scalar in string {
                // Check isEmoji and count emoji only one symbol
                guard scalar.properties.isEmojiPresentation && string.description.count == 1 else {
                    // Hide Save button
                    buttonSave.isEnabled = false
                    
                    // Show Error alert
                    showAlert(title: "Error Symbol", message: "Please enter only one Emoji symbol")
                    
                    // Set last text to TextField
                    sender.text = String(lastString)
                    return
                }
                // print("\(scalar.description)")
            }
        }
        
        buttonSave.isEnabled = checkTextField()
    }
    
}
