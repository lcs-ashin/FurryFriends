//
//  ContentView.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    @State var currentImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    // The input given from the user (note)
    @State var inputGiven = ""
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            // Shows the main image
            RemoteImageView(fromURL: currentImage)
            
            // Buttons
            HStack {
                // Favourite Button
                Image(systemName: "pawprint.circle")
                    .foregroundColor(.secondary)
                
                // Next Image
                Image(systemName: "arrow.forward.circle")
                    .foregroundColor(.secondary)
            }
            .font(.system(size: 70))
            
            // Make a note about the image
            TextField("Make a note",
                      text: $inputGiven)
                .multilineTextAlignment(TextAlignment.center)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 20))
                .padding()
            
            // Navigation link to the favourites view
                NavigationLink(destination: FavouritesView()) {
                    HStack {
                        Text("Favourites")
                            
                        Image(systemName: "list.bullet")
                    }
                    .foregroundColor(.primary)
                    .font(.system(size: 25).bold())
                }

            Spacer()
        }
        // Runs once when the app is opened
        .task {
            
            // Example images for each type of pet
            let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
            let remoteDogImage = "https://images.dog.ceo/breeds/labrador/lab_young.JPG"
            
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
            currentImage = URL(string: remoteDogImage)!
                        
        }
        .navigationTitle("Furry Friends")
        
    }
    
    // MARK: Functions
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
