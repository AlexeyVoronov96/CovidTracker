//
//  CountryHeaderRow.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct CountryHeaderRow: View {
    var body: some View {
        HStack(alignment: .center) {
            Text(verbatim: "Country")
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            Divider()
            Text(verbatim: "Confirmed")
                .frame(width: 90)
            Divider()
            Text(verbatim: "Deaths")
                .frame(width: 60)
            Divider()
            Text(verbatim: "Recovered")
                .frame(width: 90)
        }
    }
}

struct CountryHeaderRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryHeaderRow()
    }
}
