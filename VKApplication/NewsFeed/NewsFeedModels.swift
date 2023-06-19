//
//  NewsFeedModels.swift
//  VKApplication
//
//  Created by Дмитрий Пономарев on 17.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getData
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feedResponse: FeedResponse)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case showNewsFeed(viewModel: FeedCell)
            }
        }
    }
}

struct FeedCell {
    let cell: [CellItems]
}

struct CellItems {
    let photo: String
    let name: String
    let userImage: String
    let date: String
    let description: String
    let likes: String
    let comments: String
    let shares: String
    let seen: String
}

struct CellProfiles {
    let photo: String
    let name: String
}
struct CellGroups {
    let photo: String
    let name: String
}
