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
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            Divider()
            Text(verbatim: "\(country.confirmed)")
                .frame(width: 90)
            Divider()
            Text(verbatim: "\(country.deaths)")
                .frame(width: 60)
            Divider()
            Text(verbatim: "\(country.recovered)")
                .frame(width: 90)
        }
    }
}

//struct CountryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryRow()
//    }
//}
