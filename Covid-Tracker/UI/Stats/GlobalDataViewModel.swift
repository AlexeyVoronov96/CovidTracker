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
    private let covidDBService = CovidDBService()
    
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
        configure()
    }
    
    func configure() {
        loadData
            .flatMap { [weak self] _ -> AnyPublisher<CovidStates?, Error> in
                guard let self = self else {
                    return Empty(completeImmediately: true)
                        .eraseToAnyPublisher()
                }
                return self.getData()
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.globalData, on: self)
            .store(in: &bag)
    }
    
    func getData() -> AnyPublisher<CovidStates?, Error> {
        let globalDataRequest = covidService.countriesData()
        let confirmedRequest = covidService.confirmedData()
        let deathsRequest = covidService.deathsData()
        let recoveredRequest = covidService.recoveredData()
        
        let requests = Publishers
            .Zip4(globalDataRequest, confirmedRequest, deathsRequest, recoveredRequest)
            .share()
        
        requests
            .map { $0.0 }
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink { [weak self] countries in
                guard let self = self else { return }
                self.covidDBService.checkCountriesAndUpdate(countries)
            }
            .store(in: &bag)
        
        return requests
            .map { CovidStates(confirmed: $0.1, deaths: $0.2, recovered: $0.3) }
            .eraseToAnyPublisher()
    }
}
