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
    
    @Published private(set) var globalData: CovidStates?
    
    func getData() {
        covidService.getGlobalData()
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.globalData, on: self)
            .store(in: &bag)
    }
}
