//
//  Storage.swift
//  Notes
//
//  Created by Cat on 5/23/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class Storage {
    static var shared = Storage()
    var notes: [NoteModel] = []
    
    private init() {}
    
}
