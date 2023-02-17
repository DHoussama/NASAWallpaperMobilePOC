//
//  BookmarksScreen.swift
//  iosApp
//
//  Created by Pavlo Kravchenko on 17.02.2023.
//  Copyright © 2023 mdgroup. All rights reserved.
//

import SwiftUI

struct BookmarksScreen: View {
    
    @StateObject
    var viewModel = getBookmarksViewModel()
    
    @Binding
    var tabSelection: Int
    
    let bookmarkNotification = NotificationCenter.default.publisher(for: .BookmarkNotification)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.wallpapers.indices, id: \.self) { index in
                        NavigationLink(destination: WallpaperScreen(item: viewModel.wallpapers[index])) {
                            WallpaperItem(item: viewModel.wallpapers[index])
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onReceive(bookmarkNotification) { _ in
            viewModel.fetch()
        }
    }
}

struct BookmarksScreen_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksScreen(tabSelection: .constant(2))
    }
}
