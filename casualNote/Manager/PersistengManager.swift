//
//  PersistengManager.swift
//  casualNote
//
//  Created by 胡俊峰 on 2/8/20.
//  Copyright © 2020 CasualNotes. All rights reserved.
//

import Foundation
func saveNotes(notes: [Note]) {
    do {
        let data = try JSONEncoder().encode(notes)
        UserDefaults.standard.set(data, forKey: "notes")
    } catch {
        print(error)

    }
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
}

// 新增一个笔记时的存取方法
func saveNotesWithSingleNote(note:Note) -> Void {
    var notes = getNotes()
    notes.append(note)
    saveNotes(notes: notes)
}

// 获取笔记
func getNotes()->[Note] {
    var notes:[Note]?
    
    if let data = UserDefaults.standard.data(forKey: "notes") {
        do {
            notes = try JSONDecoder().decode([Note].self, from: data)
        } catch {
            print(error)
        }
    }
    
    return notes ?? []
}

// 删除笔记
func deleteNoteWithIndex(index: Int) {
    var notes = getNotes()
    notes.remove(at: index)
    saveNotes(notes: notes)
}
