//
//  FavouritesView.swift
//  FurryFriends
//
//  Created by Eunbi Shin on 2022-03-01.
//

import SwiftUI

struct FavouritesView: View {
    // MARK: Stored properties
    let currentImage: DogImage
    let inputGiven: String
    
    // MARK: Computed properties
    var body: some View {
        List {
            HStack {
                RemoteImageView(fromURL: URL(string: currentImage.message)!)
                Text("\(inputGiven)")
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
