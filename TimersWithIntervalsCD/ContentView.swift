//
//  ContentView.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/28/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import CoreData

struct Editor: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var timer: Timers
    var mode: EditMode = .inactive
    var tempus: TempusNova = TempusNova()

    var body: some View {
        Group {
            if self.mode == .active {
                TimerForm(timer: TempusNova.copyTimer(from: timer, to: tempus))
                Button(action: {
                    TempusFaci.update(from: self.tempus, context: self.managedObjectContext)
                } ) { Text("Update") }
            } else {
                DisplayTimer(timer: self.timer)
            }
        }
    }
}

struct TimerForm: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var timer: TempusNova = TempusNova()

    var body: some View {
        Form {
            Section(header: Text("Add New Timer")) {
                TextField("Name", text: self.$timer.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                NavigationLink(destination: TimesForm(timer: self.timer)) {
                    Text("Edit Times").font(.headline).foregroundColor(.black)
                }
                NavigationLink(destination: SoundsForm(timer: self.timer)) {
                    Text("Edit Sounds").font(.headline).foregroundColor(.black)
                }
                VStack(alignment: .center) {
                    Button(action: {
                        _ = TempusFaci.add(from: self.timer, context: self.managedObjectContext)
                    } ) { Text("Add") }
                }
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.editMode) private var editMode
    
    var soundData = SoundFileData()

    @FetchRequest(fetchRequest: Timers.allTimersFetchRequest()) var timers: FetchedResults<Timers>

    @State private var isEditMode: EditMode = .inactive
    @State private var selection: String? = ""
    @State private var isAddingTimer: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    Group {
                        if self.isAddingTimer {
                            TimerForm().frame(width: geometry.size.width * 0.9, height: 210, alignment: .center)
                        } else {
                            TimerForm().hidden().frame(width: geometry.size.width, height: 0, alignment: .center)
                        }
                        Section(header: Text("Timers").font(.headline).foregroundColor(.blue)) {
                            ForEach(self.timers, id: \.id) { timerX in
                                NavigationLink(destination: Editor(timer: timerX, mode: self.isEditMode), tag: timerX.id, selection: self.$selection) {
                                    VStack(alignment: .leading) {
                                        Text(timerX.name).font(.headline).foregroundColor(.red)
                                        HStack {
                                            Text(timerX.duration.toString()).font(.footnote)
                                            Spacer()
                                            Text(timerX.interlude.toString()).font(.footnote)
                                        }
                                    }
                                }
                                .gesture(TapGesture().onEnded {
                                    self.selection = timerX.id
                                })
                            }
                            .onDelete(perform: self.delete)
                            .onMove(perform: self.move)
                        }
                    }
                }
                .navigationBarTitle(Text("Timers").font(.title).bold(), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    Button(action: {
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        }) { Text("Save")}.disabled(!self.managedObjectContext.hasChanges)
                    },
                    trailing: HStack {
                    Button(action: {
                        self.$isEditMode.wrappedValue.toggle()
                    })
                    {
                        Image(systemName: self.$isEditMode.wrappedValue == .active ? "pencil.slash" : "pencil")
                    }.padding()
                    Spacer()
                    Button(action: {
                        self.isAddingTimer.toggle()
                    })
                    {
                        Image(systemName: self.isAddingTimer ? "checkmark" : "plus")
                    }
                }).environment(\.editMode, self.$isEditMode)
                .animation(.default)
            }
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
        let timerToDelete = self.timers[offsets.first!]
        self.managedObjectContext.delete(timerToDelete)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }

        self.reIndex()
    }
}

extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
