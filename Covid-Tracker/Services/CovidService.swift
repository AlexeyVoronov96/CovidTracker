//
//  CovidService.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import Foundation
import Combine
import CoreData

final class CovidService {
    
    private let apiProvider = APIProvider<CovidRoute>()
    private let coreDataManager = CoreDataManager.shared
    private let jsonDecoder = JSONDecoder()
    private var bag = Set<AnyCancellable>()
    
    func getGlobalData() -> AnyPublisher<CovidStates?, Error> {
        let requests = Publishers.Zip4(countriesData(), confirmedData(), deathsData(), recoveredData())
            .share()
        
        requests
            .map({ countriesData, _, _, _ -> CovidCountryResponse in
                return countriesData
            })
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink { [weak self] countries in
                guard let self = self else { return }
                self.checkCountriesAndUpdate(countries)
            }
            .store(in: &bag)
        
        return requests
            .map { _, confirmedData, deathsData, recoveredData -> CovidStates in
                return CovidStates(confirmed: confirmedData, deaths: deathsData, recovered: recoveredData)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Requests
private extension CovidService {
    
    func countriesData() -> AnyPublisher<CovidCountryResponse, Error> {
        return apiProvider.getData(from: .getGlobalData)
            .decode(type: CovidCountryResponse.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    func confirmedData() -> AnyPublisher<CovidStateModel, Error> {
        return apiProvider.getData(from: .getConfirmedData)
            .decode(type: CovidStateModel.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    func deathsData() -> AnyPublisher<CovidStateModel, Error> {
        return apiProvider.getData(from: .getDeathData)
            .decode(type: CovidStateModel.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    func recoveredData() -> AnyPublisher<CovidStateModel, Error> {
        return apiProvider.getData(from: .getRecoveredData)
            .decode(type: CovidStateModel.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

// MARK: - Local Data
private extension CovidService {
    
    func checkCountriesAndUpdate(_ countries: CovidCountryResponse) {
        countries.forEach { country in
            if let fetchedCountry = self.searchFor(country: country.attributes) {
                fetchedCountry.update(country: country.attributes)
            } else {
                Country.create(country: country.attributes)
            }
        }
        coreDataManager.saveContext()
    }
    
    func searchFor(country: CovidCountryModel) -> Country? {
        let fetchRequest = NSFetchRequest<Country>(entityName: "Country")
        
        fetchRequest.predicate = NSPredicate(format: "id == %i", Int16(country.id))
        
        do {
            let fetchedCountries = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return fetchedCountries.first
        } catch {
            return nil
        }
    }
}
