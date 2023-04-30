//
//  NotesViewModel.swift
//  ToDoList
//
//  Created by David Bueno Castro on 30/4/23.
//

import Foundation
import SwiftUI

final class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] =  []
    
    private let userDefaults: UserDefaults = .standard
    
    init() {
        notes =  getAllNotes()
    }
                             
    func saveNote(description: String) {
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNotes()
    }
    
    func removeNote(withId id: String) {
        notes.removeAll(where: {$0.id == id})
        encodeAndSaveAllNotes()
    }
    
    func updateFavoriteNote(note: Binding<NoteModel>) {
        note.wrappedValue.isFavorited = !note.wrappedValue.isFavorited
        encodeAndSaveAllNotes()
    }
    
    private func encodeAndSaveAllNotes() {
        if let encoded =  try? JSONEncoder().encode(notes) {
            userDefaults.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel] {
        let decoder = JSONDecoder()
        do {
            if let notesData = userDefaults.object(forKey: "notes") as? Data {
                let notes = try decoder.decode([NoteModel].self, from: notesData)
                return notes
            }
            
        } catch {
                print("Fallo al decodificar el JSON")
            }
            return []
    }
}
