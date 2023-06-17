//
//  NewsFeedPresenter.swift
//  VKApplication
//
//  Created by Дмитрий Пономарев on 17.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(let feed):
            
            
            let feedItems = feed.items.map { feedItems in
                translateData(data: feedItems)
            }
            let feedViewModel = FeedCell(cell: feedItems)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.showNewsFeed(viewModel: feedViewModel))
            print("presenter")
        }
        
    }
    
    func translateData(data: FeedItems) -> Cell {
        return Cell.init(userImage: String(data.postId),
                  date: String(data.date),
                  description: String(data.text ?? ""),
                  likes: String(data.likes?.count ?? 0),
                  comments: String(data.comments?.count ?? 0),
                  shares: String(data.shares?.count ?? 0),
                  seen: String(data.views?.count ?? 0))
    }
    
}
