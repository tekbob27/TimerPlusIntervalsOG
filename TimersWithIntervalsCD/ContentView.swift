//
//  ContentView.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/28/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import CoreData

struct TrailingListItemsView: View {
    @Environment(\.editMode) var mode
    var actionProvider: ContentView
    var body: some View {
        HStack {
            EditButton().padding()
            
            Spacer()
            Button(action: {
                self.actionProvider.addItem()
            })
            {
                Text("+")
            }
        }
    }
}

struct TimerRow: View {
    var timerX: TimerEntity
    @Environment(\.editMode) var mode

    var body: some View {
        VStack {
            if mode?.wrappedValue == .active {
                VStack {
                    NavigationLink(destination: EditTimerForm(timer: timerX)) {
                        VStack(alignment: .leading) {
                            Text(timerX.name ?? "").font(.headline).foregroundColor(.red)
                            HStack {
                                Text(timerX.duration?.toString() ?? "00:00:00").font(.footnote)
                                Spacer()
                                Text(timerX.interval?.toString() ?? "00:00:00").font(.footnote)
                            }
                        }
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    Text(timerX.name ?? "").font(.headline)
                    HStack {
                        Text(timerX.duration?.toString() ?? "00:00:00").font(.footnote)
                        Spacer()
                        Text(timerX.interval?.toString() ?? "00:00:00").font(.footnote)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    // ❇️ Core Data property wrappers
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.editMode) var mode

    // ❇️ The BlogIdea class has an `allIdeasFetchRequest` static function that can be used here
    @FetchRequest(fetchRequest: TimerEntity.allTimersFetchRequest()) var timers: FetchedResults<TimerEntity>
    
    // ℹ️ Temporary in-memory storage for adding new blog ideas
    @State private var newName = ""
    @State private var editing: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach(self.timers, id: \.id) { timerX in
                    VStack {
                        NavigationLink(destination: EditTimerForm(timer: timerX)) {
                            VStack(alignment: .leading) {
                                Text(timerX.name ?? "").font(.headline).foregroundColor(.red)
                                HStack {
                                    Text(timerX.duration?.toString() ?? "00:00:00").font(.footnote)
                                    Spacer()
                                    Text(timerX.interval?.toString() ?? "00:00:00").font(.footnote)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationBarTitle(Text("Timers").font(.title).bold(), displayMode: .inline)
            .navigationBarItems(trailing: TrailingListItemsView(actionProvider: self))
        }
    }

    func reIndex() {
        var counter: Int64 = 1
        timers.forEach({ entity in
            entity.order = counter
            try! entity.managedObjectContext?.save()
            counter += 1
        })
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func addItem() {
        let timer = TimerEntity(context: self.managedObjectContext)
        timer.name = "New Timer \(timers.count)"
        timer.order = Int64(timers.count)
        timer.id = UUID().uuidString
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        let start = source.first ?? 0
        let end = destination

        let timerToMove = timers[start]

        if end - start < 0 {
            for i in end..<start {
                let timer = timers[i]
                timer.order += 1
            }
        } else if end - start > 0 {
            for i in start..<end {
                let timer = timers[i]
                timer.order += 1
            }
        }
        timerToMove.order = Int64(end)

        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }

    func delete(at offsets: IndexSet) {
        // ❇️ Gets the BlogIdea instance out of the blogIdeas array
        // ❇️ and deletes it using the @Environment's managedObjectContext
        let blogIdeaToDelete = self.timers[offsets.first!]
        self.managedObjectContext.delete(blogIdeaToDelete)
        
        self.reIndex()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
