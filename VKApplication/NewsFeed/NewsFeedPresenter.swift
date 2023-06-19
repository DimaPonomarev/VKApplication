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

//MARK: - class NewsFeedPresenter


class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    
    //MARK: - Send data in needed format to VewController

    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(let feed):
            let feedItems = feed.items.map { feedItems in
                translateData(items: feedItems, profile: feed.profiles, groups: feed.groups)
            }
            
            let feedViewModel = FeedCell(cell: feedItems)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.showNewsFeed(viewModel: feedViewModel))
        }
    }
    
    //MARK: - Trasnslate data from icomming format to needed format in Cell
    
    private func translateData(items: FeedItems, profile: [FeedProfiles], groups: [FeedGroups]) -> CellItems {
        
        let profile = self.selectPhotoInProfileOrGroup(for: items.sourceId, profiles: profile, groups: groups)
        
        return CellItems.init(photo: profile.photo ,
                              name: profile.name ,
                              userImage: String(items.postId),
                              date: String(items.date),
                              description: String(items.text ?? ""),
                              likes: String(items.likes?.count ?? 0),
                              comments: String(items.comments?.count ?? 0),
                              shares: String(items.shares?.count ?? 0),
                              seen: String(items.views?.count ?? 0))
    }
    
    //MARK: - Divide profile image into images from userProfile feeds and images from groupProfiles feeds

    private func selectPhotoInProfileOrGroup(for sourceID: Int, profiles: [FeedProfiles], groups: [FeedGroups]) -> ProfileRepresentative {
        let profilesOrGroups: [ProfileRepresentative] = sourceID >= 0 ? profiles : groups
        let normalSourceId = sourceID >= 0 ? sourceID : -sourceID
        let profileRepresentative = profilesOrGroups.first { (myProfileRepresentative) in
            myProfileRepresentative.id == normalSourceId
        }
        return profileRepresentative!
    }
}
