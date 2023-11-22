//
//  EventViewModel.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 22.11.2023.
//
import Combine
import SwiftUI

class EventViewModel: ObservableObject {
    
    var eventKitViewModel = EventKitViewModel()
    
    private let dataSource: EventDataSource
    
    @Published var events: [IventModel] = []
    
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
    
    init(dataSource: EventDataSource = EventDataSource.shared) {
        self.dataSource = dataSource
        self.events = dataSource.fetchIvents()
        headerTitle = createHeaderTitle(from: .now)
        sinkToProperties()
    }
    
    var addButtonIsDisabled: AnyPublisher<Bool, Never> {
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
        addButtonIsDisabled.sink { isDisable in
            self.newEventIsDisable = isDisable
        }
        .store(in: &cancellable)
    }
    
    func addNewIvent() {
        let newIvent = IventModel(title: title, notes: notes, date: date)
        appendEvent(event: newIvent)
        title = ""
        notes = ""
        date = .now
    }
    
    func getAllEventsFromCalendar() {
        eventKitViewModel.insertEventsFromCalendar()
        let arrayEvents = eventKitViewModel.eventsFromCalendar
        if !arrayEvents.isEmpty {
            for newEvent in arrayEvents {
                if !events.contains(where: { newEvent.title == $0.title}) {
                    appendEvent(event: newEvent)
                }
            }
            eventKitViewModel.eventsFromCalendar = []
        }
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
    
    func appendEvent(event: IventModel) {
        dataSource.appendIvent(ivent: event)
    }
    
    func removeEvent(_ event: IventModel) {
        dataSource.removeIvent(event)
        guard let index = events.firstIndex(of: event) else {return}
        events.remove(at: index)
    }
    
}

