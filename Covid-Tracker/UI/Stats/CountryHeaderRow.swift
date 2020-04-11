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
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text(verbatim: "Conf.")
                .font(.subheadline)
                .frame(width: 60)
            Divider()
            Text(verbatim: "Deaths")
                .font(.subheadline)
                .frame(width: 60)
            Divider()
            Text(verbatim: "Recov.")
                .font(.subheadline)
                .frame(width: 60)
        }
    }
}

struct CountryHeaderRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryHeaderRow()
    }
}
