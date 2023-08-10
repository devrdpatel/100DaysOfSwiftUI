//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Dev Patel on 7/11/23.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortType: String {
        case name = "Name", recentlyAdded = "Recent"
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortOptions = false
    @State private var sortOption = SortType.name
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(filteredProspects) { prospect in
                        VStack {
                            HStack {
                                if filter == .none {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 10, height: 10)
                                        .opacity(prospect.isContacted ? 0 : 1)
                                }
                                VStack(alignment: .leading) {
                                    Text(prospect.name)
                                        .font(.headline)
                                    Text(prospect.emailAddress)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .swipeActions {
                            if prospect.isContacted {
                                Button {
                                    prospects.toggle(prospect: prospect)
                                } label: {
                                    Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                                }
                                .tint(.blue)
                            } else {
                                Button {
                                    prospects.toggle(prospect: prospect)
                                } label: {
                                    Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                                }
                                .tint(.green)
                                
                                Button {
                                    addNotification(for: prospect)
                                } label: {
                                    Label("Remind Me", systemImage: "bell")
                                }
                                .tint(.orange)
                            }
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button("Sort by: \(sortOption.rawValue)") {
                        isShowingSortOptions = true
                    }
                    .padding()
                }
                .background(.clear)
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
            .confirmationDialog("Choose how to sort prospects", isPresented: $isShowingSortOptions) {
                Button("Name") { sortOption = .name }
                Button("Recently Added") { sortOption = .recentlyAdded }
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        var filteredList: [Prospect]
        switch filter {
        case .none:
            filteredList = prospects.people
        case .contacted:
            filteredList = prospects.people.filter {
                $0.isContacted
            }
        case .uncontacted:
            filteredList = prospects.people.filter {
                !$0.isContacted
            }
        }
        return filteredList.sorted(by: sortOption == .name ? Prospect.sortByName(lhs:rhs:) : Prospect.sortByRecent(lhs:rhs:))
        // Can also return filteredList.reversed for Recent Sorting
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else {
                return
            }
            let prospect = Prospect()
            prospect.name = details[0]
            prospect.emailAddress = details[1]
            prospects.add(prospect)
        case .failure(let error):
            print("Something failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = "\(prospect.emailAddress)"
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Uh oh!")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
