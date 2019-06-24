//
//  HomeController.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-20.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var tableViewDataSource: HomeDataSource?
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNavBar()
        loadLayout()
        
        viewModel.loadPosts()
    }
    
    private func loadNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.home
    }
    
    private func loadLayout() {
        HomeDataSource.setupTableView(tableView: tableView)
        tableViewDataSource = HomeDataSource.init(viewModel: viewModel)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        
        viewModel.posts.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func showALertError(message: String) {
        let alert = UIAlertController(title: Constants.ops,
                                      message: message,
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: Constants.ok,
                                     style: .default,
                                     handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

extension HomeController: HomeDelegate {
    func didFail(err: Error) {
        showALertError(message: err.localizedDescription)
    }
}
