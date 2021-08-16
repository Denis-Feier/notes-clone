//
//  NotesCloneApp.swift
//  NotesClone
//
//  Created by Denisu on 16.07.2021.
//

import SwiftUI

@main
struct NotesCloneApp: App {
    
    @StateObject var myNotes = MyNotes()
    
    var body: some Scene {
        WindowGroup {
            ContentView(myNotes: myNotes)
        }
    }
}
