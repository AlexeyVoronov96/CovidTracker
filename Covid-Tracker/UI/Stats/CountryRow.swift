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
                .font(.subheadline)
                .frame(width: 60)
            Divider()
            Text(verbatim: "\(country.deaths)")
                .font(.subheadline)
                .frame(width: 60)
            Divider()
            Text(verbatim: "\(country.recovered)")
                .font(.subheadline)
                .frame(width: 60)
        }
    }
}
