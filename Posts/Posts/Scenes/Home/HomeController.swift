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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupPosts()
    }
    
    private func loadNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.home
    }
    
    private func loadLayout() {
        viewModel.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 25
        tableView.registerNib(cellClass: HomeCell.self)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionReviews>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeue(cellClass: HomeCell.self, indexPath: indexPath)
                cell.configure(postName: item.title)
                return cell
        })
        
        viewModel.postObservable.flatMap { (posts) -> Observable<[SectionReviews]> in
            var array: [SectionReviews] = []
            posts.map { post in
                array.append(SectionReviews(items: [post], header: ""))
            }
            return .just(array)
        }.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let post = self.viewModel.postSelected(for: indexPath.section)
            self.viewModel.coordinator?.moveToDetailsScreen(self, didSelectPost: post)
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
    func didFinish(_ action: HomeAction) {
        switch action {
        case .alertError(let err):
            showALertError(message: err.localizedDescription)
        case .seeDetails(let post):
            viewModel.coordinator?.moveToDetailsScreen(self, didSelectPost: post)
        }
    }
}
