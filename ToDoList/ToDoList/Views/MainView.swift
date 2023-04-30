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
                    ForEach($notesViewModel.notes, id: \.id) { $nota in
                        HStack {
                            if nota.isFavorited {
                                Text("🌟")
                            }
                            Text(nota.description)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                notesViewModel.updateFavoriteNote(note: $nota)
                            } label: {
                                Label("Favorito", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading){
                            Button {
                                notesViewModel.removeNote(withId: nota.id)
                            } label: {
                                Label("Borrar", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                    }
                }
                .background(.black)
                .scrollContentBackground(.hidden)
            
            }
            .navigationTitle("TO-DO-LIST")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Text(notesViewModel.getNumberOfNotes())
            }.foregroundColor(.green)
            .background( .black, ignoresSafeAreaEdges: .all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
