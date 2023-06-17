//
//  Assembly.swift
//  VKApplication
//
//  Created by Дмитрий Пономарев on 17.06.2023.
//

import Foundation

class Assembly {
    
    func setup(viewController: NewsFeedViewController) {
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
}
