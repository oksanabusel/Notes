//
//  NoteTableCell.swift
//  Notes
//
//  Created by Cat on 5/23/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class NoteTableCell: UITableViewCell {
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeOfCreationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func setData(data: NoteModel) {
        noteLabel.text = data.noteDescription
        timeOfCreationLabel.text = data.creationDate
        locationLabel.text = data.location
    }
    
}
