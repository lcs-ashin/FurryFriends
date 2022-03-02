//
//  FavouritesView.swift
//  FurryFriends
//
//  Created by Eunbi Shin on 2022-03-01.
//

import SwiftUI

struct FavouritesView: View {
    var body: some View {
        List {
           Text("This is a place holder")
        }
        .navigationTitle("Favourites")
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavouritesView()
        }
    }
}
