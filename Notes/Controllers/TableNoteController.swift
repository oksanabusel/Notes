//
//  TableNoteController.swift
//  Notes
//
//  Created by Cat on 5/23/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class TableNoteController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    private var selectedRowIndex: Int?

    struct Segues {
        static let detailsSegue = "showDescriptionSegue"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.shared.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableCell", for: indexPath) as! NoteTableCell
        
        let data = Storage.shared.notes[indexPath.row]
        cell.setData(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRowIndex = indexPath.row
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TableNoteController.Segues.detailsSegue {
            let destination = segue.destination as! DescriptionController
            let data = Storage.shared.notes[selectedRowIndex!]

            destination.noteDescription = data.noteDescription
        }
    }
    
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        noteTable.setEditing(noteTable.isEditing, animated: true)
        
        if noteTable.isEditing == false {
            editBarButton.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            editBarButton.title = "Done"
            addBarButton.isEnabled = false
        }

    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = Storage.shared.notes[sourceIndexPath.row]
        
        Storage.shared.notes.remove(at: sourceIndexPath.row)
        Storage.shared.notes.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Storage.shared.notes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}
