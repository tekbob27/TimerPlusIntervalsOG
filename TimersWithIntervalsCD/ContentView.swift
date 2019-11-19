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
    var timerX: Timers
    @Environment(\.editMode) var mode

    var body: some View {
        VStack {
            if mode?.wrappedValue == .active {
                VStack {
                    NavigationLink(destination: EditTimerForm().environmentObject(timerX)) {
                        VStack(alignment: .leading) {
                            Text(timerX.name).font(.headline).foregroundColor(.red)
                            HStack {
                                Text(timerX.duration.toString()).font(.footnote)
                                Spacer()
                                Text(timerX.interlude.toString()).font(.footnote)
                            }
                        }
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    Text(timerX.name).font(.headline)
                    HStack {
                        Text(timerX.duration.toString()).font(.footnote)
                        Spacer()
                        Text(timerX.interlude.toString()).font(.footnote)
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
    var soundData = SoundFileData()

    // ❇️ The BlogIdea class has an `allIdeasFetchRequest` static function that can be used here
    @FetchRequest(fetchRequest: Timers.allTimersFetchRequest()) var timers: FetchedResults<Timers>
    
    // ℹ️ Temporary in-memory storage for adding new blog ideas
    @State private var newName = ""
    @State private var editing: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach(self.timers, id: \.id) { timerX in
                    VStack {
                        NavigationLink(destination: EditTimerForm().environmentObject(timerX)) {
                            VStack(alignment: .leading) {
                                Text(timerX.name).font(.headline).foregroundColor(.red)
                                HStack {
                                    Text(timerX.duration.toString()).font(.footnote)
                                    Spacer()
                                    Text(timerX.interlude.toString()).font(.footnote)
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
        let timer = Timers(context: self.managedObjectContext)
        timer.duration = Duration(context: self.managedObjectContext)
        timer.interlude = Interlude(context: self.managedObjectContext)
        // Duration.fromString(timer.duration, timeString: "00:00:00")
        // Interlude.fromString(timer.interlude, timeString: "00:00:00")
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
        let blogIdeaToDelete = self.timers[offsets.first!]
        self.managedObjectContext.delete(blogIdeaToDelete)
        
        self.reIndex()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
