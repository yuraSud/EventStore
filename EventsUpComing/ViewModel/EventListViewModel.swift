//
//  EventListViewModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//
import Combine
import SwiftUI
import SwiftData

enum Period: Int, CaseIterable, Identifiable {
    case week
    case month
    case year
    case custom
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .week: "Week"
        case .month: "Month"
        case .year: "Year"
        case .custom: "Custom"
        }
    }
}

class EventListViewModel: ObservableObject {
    
    
    var events: [IventModel] = []
    var context: ModelContext
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var isDatePickerPresent = false
    @Published var selectedIndexButton: Period = .week {
        didSet {
            self.headerTitle = self.createHeaderTitle(from: .now)
        }
    }
    @Published var arrayIvents: [IventModel] = []
    @Published var headerTitle = ""
    @Published var selectDate: Date = Date() {
        didSet {
            self.headerTitle = self.createHeaderTitle(from: .now)
        }
    }
    
    @Published var title = ""
    @Published var notes = ""
    @Published var date = Date()
    @Published var newEventIsDisable = false
    
    init(context: ModelContext) {
        self.context = context
        sinkToProperties()
        headerTitle = createHeaderTitle(from: .now)
    }
    
    var addIsDisabled: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($title, $notes, $date)
            .map { title, notes, date in
                let titleIsNotEmpty = !title.isEmpty
                let notesIsNotEmpty = !notes.isEmpty
                let differenceDay = date.distance(from: .now, only: .day, calendar: .current)
                let newDate = differenceDay != 0
                return titleIsNotEmpty && notesIsNotEmpty && newDate
            }
            .eraseToAnyPublisher()
    }
    
    var endDate: Date {
        let calendar = Calendar.current
        var resultDate: Date?
        switch selectedIndexButton {
        case .week:
            resultDate = calendar.date(byAdding: .weekOfYear, value: 1, to: Date())
        case .month:
            resultDate = calendar.date(byAdding: .month, value: 1, to: Date())
        case .year:
            resultDate = calendar.date(byAdding: .year, value: 1, to: Date())
        case .custom:
            resultDate = selectDate
        }
        guard let date = resultDate else { return .now }
        return date
    }
    
    var predicateFilter: Predicate<IventModel> {
        let dateNow = Date.now
        return #Predicate<IventModel> { event in
            event.date > dateNow && event.date <= endDate
        }
    }
    
    static func currentPredicate() -> Predicate<IventModel> {
        let currentDate = Date.now
        
        return #Predicate<IventModel> { event in
            event.date > currentDate
        }
    }
    
    func sinkToProperties() {
        addIsDisabled.sink { isDisable in
            self.newEventIsDisable = isDisable
        }
        .store(in: &cancellable)
    }
    
    func addIvent() {
        let newIvent = IventModel(title: title, notes: notes, date: date)
        context.insert(newIvent)
        title = ""
        notes = ""
        date = .now
    }
    
    func deleteIvent(event: IventModel) {
        context.delete(event)
    }
    
    private func createHeaderTitle(from date: Date) -> String {
        var result = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd - "
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MMM dd, yyy"
        
        result = formatter.string(from: date) + formatter2.string(from: endDate)
        
        return result
    }
}


