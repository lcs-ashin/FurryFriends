//
//  SavedDog.swift
//  FurryFriends
//
//  Created by Eunbi Shin on 2022-03-02.
//

struct SavedDog: Decodable, Hashable, Encodable {
    let imageAdress: String
    let comment: String
}
