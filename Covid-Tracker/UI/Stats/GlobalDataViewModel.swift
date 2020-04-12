//
//  GlobalDataViewModel.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import Foundation
import Combine

final class GlobalDataViewModel: ObservableObject {
    private let covidService = CovidService()
    
    private var bag = Set<AnyCancellable>()
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, h:mm a"
        return dateFormatter
    }
    
    var currentDateString: String {
        return dateFormatter.string(from: Date()) 
    }
    
    @Published private(set) var globalData: CovidStates?
    
    let loadData = PassthroughSubject<Void, Error>()
    
    init() {
        getData()
    }
    
    func getData() {
        loadData
            .flatMap { [weak self] _ -> AnyPublisher<CovidStates?, Error> in
                guard let self = self else {
                    return Empty(completeImmediately: true)
                        .eraseToAnyPublisher()
                }
                return self.covidService.getGlobalData()
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.globalData, on: self)
            .store(in: &bag)
    }
}
