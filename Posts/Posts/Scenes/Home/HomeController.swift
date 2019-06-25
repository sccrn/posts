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
import RxDataSources

class HomeController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionPosts> = {
        RxTableViewSectionedReloadDataSource<SectionPosts>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeue(cellClass: HomeCell.self, indexPath: indexPath)
            cell.configure(postName: item.title)
            return cell
        })
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshHome), for: .valueChanged)
        return refreshControl
    }()
    
    private let disposeBag = DisposeBag()
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
        loadLayout()
        loadNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupPosts()
    }
    
    private func loadNavBar() {
        navigationItem.title = Constants.home
    }
    
    private func loadLayout() {
        viewModel.delegate = self
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.registerNib(cellClass: HomeCell.self)
        tableView.addSubview(refreshControl)
        
        viewModel.postObservable.flatMap { (posts) -> Observable<[SectionPosts]> in
            var array: [SectionPosts] = []
            posts.forEach { post in
                array.append(SectionPosts(items: [post], header: ""))
            }
            return .just(array)
        }.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let post = self.viewModel.postSelected(for: indexPath.section)
            self.viewModel.coordinator?.moveToDetailsScreen(post)
        }).disposed(by: disposeBag)
    }
    
    @objc private func refreshHome() {
        viewModel.setupPosts()
        refreshControl.endRefreshing()
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
    func didFinish(_ error: Error) {
        showALertError(message: error.localizedDescription)
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 65 : 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
