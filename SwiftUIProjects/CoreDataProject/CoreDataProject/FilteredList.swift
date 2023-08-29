//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Dev Patel on 6/23/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    enum PredicateKeys: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS[c]"
    }
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, predicateKey: PredicateKeys, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicateKey) %@", filterKey, filterValue))
        
        self.content = content
    }
}
