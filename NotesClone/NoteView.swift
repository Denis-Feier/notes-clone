//
//  NoteView.swift
//  NotesClone
//
//  Created by Denisu on 17.07.2021.
//

import SwiftUI

struct NoteView: View {
    
    @State private var title = ""
    @State private var noteText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View {
        TextView(text: $noteText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        print("Done")
                    }
                }
            }
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        return textView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = context.coordinator.updateAttributedString()
    }
    
    typealias UIViewType = UITextView
    
    class Coordinator: NSObject {
        var parent: TextView
        init(_ textView: TextView) {
            self.parent = textView
        }
        func updateAttributedString() -> NSAttributedString {
            let attrs = [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)
            ]
            let attrString = NSAttributedString(string: parent.text, attributes: attrs)
            return attrString
        }
    }
}


struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
