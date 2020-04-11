//
//  CountryRow.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct CountryRow: View {
    let country: Country
    
    var body: some View {
        HStack(alignment: .center) {
            Text(verbatim: country.name ?? "")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text(verbatim: "\(country.confirmed)")
                .frame(width: 80)
            Divider()
            Text(verbatim: "\(country.deaths)")
                .frame(width: 80)
            Divider()
            Text(verbatim: "\(country.recovered)")
                .frame(width: 80)
        }
    }
}
