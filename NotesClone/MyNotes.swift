//
//  MyNotes.swift
//  NotesClone
//
//  Created by Denisu on 16.07.2021.
//

import Foundation

class MyNotes: ObservableObject {
    @Published var folders = [Folder]()
}

struct Folder: Identifiable {
    var id = UUID()
    var name: String
    var notes: [Note] = randomNotes
}

struct Note: Identifiable {
    var id = UUID()
    var title: String
    var noteText = ""
}


var randomFolders = [
    Folder(name: "Whatever"),
    Folder(name: "Ramdom shit"),
    Folder(name: "Porn")
]

var randomNotes = [
    Note(title: "note1"),
    Note(title: "note2"),
    Note(title: "note3")
]
