//
//  Tabber.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import SwiftUI

struct Tabbar: View {
    @State private var selection = 0
        var body: some View {
            TabView(selection: $selection) {
                PostView()
                    .tabItem {
                        Image(systemName: "pencil")
                    }
                    .tag(0)
                PostListView()
                    .tabItem {
                        Image(systemName: "book")
                    }
                    .tag(1)
            }
        }
}

#Preview {
    Tabbar()
}
