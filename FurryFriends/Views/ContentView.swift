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
    @State var currentImage: DogImage = DogImage(message: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png",
                                                 status: "")
    
    // The input given from the user (note)
    @State var inputGiven = ""
    
    // Check if the new image is loaded
    @State var isTheNewImageLoaded: Bool = false
    
    // List of favourites
    @State var favourites: [DogImage] = []
    
    // The image and comment saved in the favourite list
    @State var favouriteDog: SavedDog = SavedDog(imageAdress: "",
                                                 comment: "")
    
    // Check if the current image already exists in the list
    @State var currentImageAddedToFavourites: Bool = false
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            // Shows the main image
            RemoteImageView(fromURL: URL(string: currentImage.message)!)
            
            // Buttons
            HStack {
                // Favourite Button
                Image(systemName: "pawprint.circle")
                    .foregroundColor(currentImageAddedToFavourites == true ? .brown : .secondary)
                    .onTapGesture {
                        // Only add to the list if it is not already there
                        if currentImageAddedToFavourites == false {
                            
                            // Adds the current image to the list
                            favourites.append(currentImage)
                            
                            // Record that we have marked this as a favourite
                            currentImageAddedToFavourites = true
                        }
                    }
                        
                        // Next Image
                        Image(systemName: "arrow.forward.circle")
                            .foregroundColor(isTheNewImageLoaded == true ? .accentColor : .secondary)
                            .onTapGesture {
                                Task {
                                    await loadNewDogImage()
                                }
                                isTheNewImageLoaded = true
                                inputGiven = ""
                            }
                    }
                    .font(.system(size: 70))
            
                // Make a note about the image
                TextField("Make a note",
                          text: $inputGiven)
                    .multilineTextAlignment(TextAlignment.center)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20))
                    .padding()
                
                HStack {
                    Text("Favourites")
                        .bold()
                
                    Spacer()
                }
            
                List(favourites, id: \.self) { currentFavourite in
                    
                    HStack {
                        RemoteImageView(fromURL: URL(string: currentFavourite.message)!)
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding(15)
                        Text("\(inputGiven)")
                            .font(.system(size: 20))
                    }
                    
                }
                
                // Navigation link to the favourites view
                //            NavigationLink(destination: FavouritesView(currentImage: currentImage,
                //                                                       inputGiven: inputGiven)) {
                //                    HStack {
                //                        Text("Favourites")
                //
                //                        Image(systemName: "list.bullet")
                //                    }
                //                    .foregroundColor(.primary)
                //                    .font(.system(size: 25).bold())
                //                }
                
              //  Spacer()
                    .padding()
        }
        .padding(20)
            // Runs once when the app is opened
            .task {
                
                await loadNewDogImage()
                
                print("I tried to load a new image")
                
            }
            .navigationTitle("Furry Friends")
    }
    
        
    
    
    // MARK: Functions
    
    // Load new dog image
    func loadNewDogImage() async {
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        // Define the type of data we want from the endpoint
        // Configure the request to the web site
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        // Try to fetch a new image
        // It might not work, so we use a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentImage"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentImage = try JSONDecoder().decode(DogImage.self, from: data)
            
            isTheNewImageLoaded = false
            currentImageAddedToFavourites = false
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block
            // populates
            print(error)
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
