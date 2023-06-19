//
//  NewsFeedViewController.swift
//  VKApplication
//
//  Created by Дмитрий Пономарев on 17.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

//MARK: - class NewsFeedViewController

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    var cellViewModel = FeedCell.init(cell: [])
    
    //MARK: - UI properties
    
    let tableView = UITableView()
    
    // MARK: - Setup
    
    private func setup() {
        
        let asembly = Assembly()
        asembly.setup(viewController: self)
    }
    
    // MARK: - Routing
    
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addViews()
        setupTableView()
        makeConstraints()
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getData)
        
    }
    
    //    MARK: - addViews
    
    func addViews() {
        view.backgroundColor = .brown
        view.addSubview(tableView)
    }
    
    
    //    MARK: - setupTableView
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: NewsFeedTableViewCell.identifier)
    }
    
    
    //    MARK: - makeConstraints
    
    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
    }
    
    //    MARK: - getting data from Presenter in needed format

    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
            
        case .showNewsFeed(viewModel: let viewModel):
            cellViewModel = viewModel
            tableView.reloadData()
        }
    }
}

//    MARK: - extension UITableViewDataSource, UITableViewDelegate

extension NewsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModel.cell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.identifier) as? NewsFeedTableViewCell else { return UITableViewCell() }
        let itemModel = cellViewModel.cell[indexPath.row]
        cell.configureView(itemModel)
        return cell
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}











