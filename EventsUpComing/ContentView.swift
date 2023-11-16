//
//  ContentView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var toDos: [Todo]
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
            List {
                Text("\(coordinator.path.count) Count")
                ForEach(toDos) { toDo in
                    NavigationLink {
                        Text("Item at \(toDo.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        VStack {
                            Text( "\(toDo.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            if let title = toDo.title {
                                Text(title)
                                    .padding(.top, 7)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    

    private func addItem() {
        withAnimation {
            let newItem = Todo(creationDate: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(toDos[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self, inMemory: true)
}
