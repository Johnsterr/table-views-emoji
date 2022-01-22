//
//  EmojiTableViewController.swift
//  EmojiTableViewController
//
//  Created by Евгений Пашко on 01.11.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    // MARK: - Properties
    let cellManager = CellManager()
    let dataManager = DataManager()
    var emojis: [EmojiModel]! {
        didSet {
            dataManager.saveEmojis(emojis)
        }
    }
    
    
    // MARK: - UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        emojis = dataManager.loadEmojis() ?? EmojiModel.loadDefaults()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSeque" else {
            return
        }
        
        guard let selectedPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        let emoji = emojis[selectedPath.row]
        let destination = segue.destination as! AddEditTableViewController
        
        destination.emoji = emoji
    }
}


// MARK: - UITableViewDataSource
extension EmojiTableViewController /*: UITableViewDataSource */ {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emoji = emojis[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell")! as! EmojiCell
        cellManager.configure(cell, with: emoji)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoje = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoje, at: destinationIndexPath.row)
        tableView.reloadData()
    }
}


// MARK: - UITableViewDelegate
extension EmojiTableViewController /*: UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            
        case .delete:
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        case .insert:
            break
            
        case .none:
            break
            
        @unknown default:
            // print(#line, #function, "Unknow case \(#file)")
            break
        }
    }
}

// MARK: - IBActions
extension EmojiTableViewController {
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {
            return
        }
        
        let source = segue.source as! AddEditTableViewController
        let emoji = source.emoji
        
        if let selectedPath = tableView.indexPathForSelectedRow {
            emojis[selectedPath.row] = emoji
            tableView.reloadRows(at: [selectedPath], with: .automatic)
            // Edited cell
        } else {
            // Added cell
            let indexParh = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [indexParh], with: .automatic)
        }
    }
}
