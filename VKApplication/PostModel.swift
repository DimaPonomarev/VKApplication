//
//  PostModel.swift
//  VKApplication
//
//  Created by Дмитрий Пономарев on 17.06.2023.
//

import Foundation

struct FeedResponeWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItems]
    let profiles: [FeedProfiles]
    let groups: [FeedGroups]
}
struct FeedItems: Decodable {
    let date: Int
    let sourceId: Int
    let postId: Int
    let comments: CountableItems?
    let likes: CountableItems?
    let text: String?
    let shares: CountableItems?
    let views: CountableItems?
}

struct CountableItems: Decodable {
    let count: Int
}

protocol ProfileRepresentative {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct FeedProfiles: Decodable, ProfileRepresentative {
    var id: Int
    let photo100: String
    let firstName: String
    let lastName: String
    
    var name: String { return "\(firstName) \(lastName)"}
    var photo: String { return photo100}
}

struct FeedGroups: Decodable, ProfileRepresentative {
    var id: Int
    let photo50: String
    let name: String
    
    var photo: String {return photo50}
    
}
