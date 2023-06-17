//
//  NewsFeedInteractor.swift
//  VKApplication
//
//  Created by Дмитрий Пономарев on 17.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    private var dataFetcher: DataFetcherProtocol = NetworkDataFetcher(network: NetworkService())
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        switch request {
        case .getData:
            dataFetcher.getFeed { [weak self] (feedResponse) in
                guard let self = self else { return }
                guard let feedResponse = feedResponse else { return }
                self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feedResponse: feedResponse))
            }
            
            print("interactor")
        }
    }
}
