//
//  PostDetailsController.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-24.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PostDetailsController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()

    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionPosts> = {
        RxTableViewSectionedReloadDataSource<SectionPosts>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeue(cellClass: DetailsCell.self, indexPath: indexPath)
                cell.configure(post: item)
                return cell
        })
    }()
    var viewModel: PostDetailsViewModel
    
    init(viewModel: PostDetailsViewModel) {
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
    }
    
    private func loadNavBar() {
        navigationItem.title = Constants.details
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done,
                                                           target: self, action: #selector(actionBackButton))
    }
    
    @objc private func actionBackButton() {
        viewModel.coordinator?.moveToHomeScreen()
    }
    
    private func loadLayout() {
        viewModel.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.registerNib(cellClass: DetailsCell.self)
        
        let item = Observable.just([SectionPosts(items: [viewModel.post.value], header: "")])
        item.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
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

extension PostDetailsController: PostDetailsDelegate {
    func didFinish(_ error: Error) {
        showALertError(message: error.localizedDescription)
    }
}
