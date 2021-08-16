//
//  ContentView.swift
//  NotesClone
//
//  Created by Denisu on 16.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var myNotes: MyNotes
    @State private var searchString = ""
    @State var showPopover = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    TextField("Search", text: $searchString)
                    Section(header:
                                Text("On My IPhone")
                                .font(.title3)
                                .foregroundColor(.black)
                                .fontWeight(.bold)) {
                        
                        if myNotes.folders.count > 0 {
                            FolderCell(name: "All on My IPhone")
                        }
                        FolderCell(name: "Notes")
                        ForEach(myNotes.folders) { folderName in
                            FolderCell(name: folderName.name)
                        }
                        .onDelete(perform: { indexSet in
                            print("Delete")
                        })
                    }.textCase(nil)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(Text("Folders"))
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Image(systemName: "folder.badge.plus")
                            .onTapGesture {
                                showPopover.toggle()
                            }
                        
                        Spacer()
                        
                        HStack {
                            Text("") //SwiftUI BUG FUCK YOU APPLE
                            NavigationLink(destination: NoteView()) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            
            if showPopover {
                NewFolderView(myNotes: myNotes, showPopover: $showPopover)
            }
            
        }
    }
}

struct FolderCell: View {
    
    var name: String
    
    var body: some View {
        NavigationLink(destination: FolderView(folderName: name)) {
            HStack {
                Image(systemName: "folder")
                Text(name)
            }
        }
    }
}

struct EditButton: View {
    var body: some View {
        Button("Edit") {
            print("Edit")
        }
    }
}

struct NewFolderView: View {
    
    @ObservedObject var myNotes: MyNotes
    @Binding var showPopover: Bool
    @State private var newFolderName = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray4))
                    .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.4, alignment: .center)
                VStack {
                    Text("New Folder")
                        .font(.headline)
                    Text("Enter a name for this folder")
                        .font(.subheadline)
                    Spacer()
                    TextField("Name", text: $newFolderName)
                        .frame(width: 200, height: 10, alignment: .center)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(7)
                    Spacer()
                    Color.gray.frame(width: 200, height: 1, alignment: .center)
                    HStack {
                        Button(action: {
                            print("Cancel")
                            showPopover.toggle()
                        }, label: {
                            Text("Cancel").frame(maxWidth: .infinity)
                        })

                        Button(action: {
                            print("Save")
                            myNotes.folders.append(Folder(name: newFolderName))
                            showPopover.toggle()
                        }, label: {
                            Text("Save").frame(maxWidth: .infinity)
                        })
                    }
                }
                .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.35)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let myNotes = MyNotes()
        myNotes.folders = randomFolders
        return ContentView(myNotes: myNotes)
    }
}
