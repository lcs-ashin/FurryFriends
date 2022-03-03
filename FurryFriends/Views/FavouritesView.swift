//
//  FavouritesView.swift
//  FurryFriends
//
//  Created by Eunbi Shin on 2022-03-01.
//

import SwiftUI

struct FavouritesView: View {
    // MARK: Stored properties
    let favouriteDog: SavedDog
    
    // MARK: Computed properties
    var body: some View {
        List {
            HStack {
                RemoteImageView(fromURL: URL(string: favouriteDog.imageAdress)!)
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding(15)
                Text("\(favouriteDog.comment)")
                    .font(.system(size: 20))
            }
        }
        .navigationTitle("Favourites")
    }
}

//struct FavouritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            FavouritesView()
//        }
//    }
//}
