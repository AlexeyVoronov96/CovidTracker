//
//  TabBarView.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    private let context = CoreDataManager.shared.managedObjectContext
    
    var body: some View {
        TabView {
            GlobalDataView()
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Text(verbatim: "Stats")
                        .font(.system(size: 22))
            }
            
            MapContainerView()
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Text(verbatim: "Map")
                        .font(.system(size: 22))
                }
        }
    }
}
