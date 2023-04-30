//
//  ContentView.swift
//  ToDoList
//
//  Created by David Bueno Castro on 28/4/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Añade una tarea")
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                TextEditor(text: $descriptionNote)
                    .foregroundColor(.green)
                    .colorMultiply(.gray)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.green, lineWidth: 2)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(3.0)
                Button("Crear Nota") {
                    notesViewModel.saveNote(description: descriptionNote)
                    descriptionNote = ""
                }
                .buttonStyle(.bordered)
                .tint(.green)
                Spacer()
                
                List {
                    ForEach(notesViewModel.notes, id: \.id) { nota in
                        HStack {
                            Text(nota.description)
                        }
                    }
                }
                .background(.black)
                .scrollContentBackground(.hidden)
            
            }
            .navigationTitle("TO-DO-LIST")
            .navigationBarTitleDisplayMode(.inline)
            .background( .black, ignoresSafeAreaEdges: .all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
