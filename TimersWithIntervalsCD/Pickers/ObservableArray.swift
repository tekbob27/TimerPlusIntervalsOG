//
//  ObservableArray.swift
//  TestEditMode
//
//  Created by Bob O'Connor on 12/2/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import Combine

class ObservableArray<T>: ObservableObject {

    @Published var array:[T] = []
    var cancellables = [AnyCancellable]()

    init(array: [T]) {
        self.array = array
    }

    func observeChildrenChanges<K>(_ type:K.Type) throws -> ObservableArray<T> where K : ObservableObject{
        let array2 = array as! [K]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })

            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
        return self
    }
}


//class ObservableCollection<T>: Collection, ObservableObject {
//    typealias ObservableCollectionType = [T]
//    
//    private var items: ObservableCollectionType
//    
//    init(items: [T]) {
//        self.items = items
//    }
//    var startIndex: ObservableCollection.Index = 0
//    
//    var endIndex: ObservableCollection.Index = 0
//    
//    var indices: ObservableCollectionType.Indices
//    
//    var isEmpty: Bool {
//        items.count == 0
//    }
//    
//    var count: Int = 0
//}
//
//extension ObservableCollection {
//    typealias Element = ObservableCollectionType.Element
//    
//    typealias Index = ObservableCollectionType.Index
//    
//    __consuming func makeIterator() -> Iterator {
//        items.makeIterator()    }
//    
//    subscript(position: ObservableCollection.Index) -> ObservableCollection.Element {
//        _read {
//            <#code#>
//        }
//    }
//    
//    subscript(bounds: Range<ObservableCollection.Index>) -> ObservableCollection.SubSequence {
//        <#code#>
//    }
//    
//    func _customIndexOfEquatableElement(_ element: ObservableCollection.Element) -> ObservableCollection.Index?? {
//        <#code#>
//    }
//    
//    func _customLastIndexOfEquatableElement(_ element: ObservableCollection.Element) -> ObservableCollection.Index?? {
//        <#code#>
//    }
//    
//    func index(_ i: ObservableCollection.Index, offsetBy distance: Int) -> ObservableCollection.Index {
//        <#code#>
//    }
//    
//    func index(_ i: ObservableCollection.Index, offsetBy distance: Int, limitedBy limit: ObservableCollection.Index) -> ObservableCollection.Index? {
//        <#code#>
//    }
//    
//    func distance(from start: ObservableCollection.Index, to end: ObservableCollection.Index) -> Int {
//        <#code#>
//    }
//    
//    func _failEarlyRangeCheck(_ index: ObservableCollection.Index, bounds: Range<ObservableCollection.Index>) {
//        <#code#>
//    }
//    
//    func _failEarlyRangeCheck(_ index: ObservableCollection.Index, bounds: ClosedRange<ObservableCollection.Index>) {
//        <#code#>
//    }
//    
//    func _failEarlyRangeCheck(_ range: Range<ObservableCollection.Index>, bounds: Range<ObservableCollection.Index>) {
//        <#code#>
//    }
//    
//    func index(after i: ObservableCollection.Index) -> ObservableCollection.Index {
//        <#code#>
//    }
//    
//    func formIndex(after i: inout ObservableCollection.Index) {
//        <#code#>
//    }
//    
//    __consuming func makeIterator() -> ObservableCollection.Iterator {
//        <#code#>
//    }
//    
//    func _customContainsEquatableElement(_ element: ObservableCollection.Element) -> Bool? {
//        <#code#>
//    }
//    
//    __consuming func _copyToContiguousArray() -> ContiguousArray<ObservableCollection.Element> {
//        <#code#>
//    }
//    
//    __consuming func _copyContents(initializing ptr: UnsafeMutableBufferPointer<ObservableCollection.Element>) -> (ObservableCollection.Iterator, Int) {
//        <#code#>
//    }
//    
//    func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<ObservableCollection.Element>) throws -> R) rethrows -> R? {
//        <#code#>
//    }
//    
//    
//}
