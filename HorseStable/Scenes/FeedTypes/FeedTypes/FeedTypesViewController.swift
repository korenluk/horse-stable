//
//  FeedTypesController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 04/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol FeedTypesViewControlling {
    var coordinator: FeedTypesCoordinating? {get set}
}

class FeedTypesViewController: UIViewController, FeedTypesViewControlling {
    
    var viewModel: FeedTypesViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var coordinator: FeedTypesCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed Type"
        tableView.register(FeedTypeCell.nib, forCellReuseIdentifier: FeedTypeCell.reuseIdentifer)
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        viewModel.updateFeedTypes()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        tableView.tableFooterView = UIView()
        tableView.allowsSelectionDuringEditing = true
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear FEED TYPES")
        viewModel.updateFeedTypes()
        tableView.reloadData()
        tableView.setEditing(false, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    @objc func add() {
        coordinator?.add()
    }
    
    @objc func edit() {
        tableView.setEditing(true, animated: true)
        navigationItem.rightBarButtonItems = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    @objc func done() {
        tableView.setEditing(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        tableView.reloadData()
    }
    
    @objc func refresh() {
        viewModel.updateFeedTypes()
        tableView.reloadData()
    }
}

extension FeedTypesViewController: FeedTypesViewModelDelegate {
    func didUpdateFeedTypes() {
        if viewModel.numberOfFeedTypes() == 0 {
            let alertController = UIAlertController(title: "VOID", message: "You dont have any feed type. Please add some.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ADD", style: .default) { alert in
                self.coordinator?.add()
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            present(alertController, animated: true, completion: nil)
        }
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func didDeleteFeedType() {
        viewModel.updateFeedTypes()
    }
    
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension FeedTypesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFeedTypes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: FeedTypeCell.self, at: indexPath)
        cell.editingAccessoryType = .disclosureIndicator
        let feedType = viewModel.feedType(at: indexPath.row)
        let input = FeedTypeCell.Input(name: feedType.name, capacity: feedType.capacity, actualCapacity: feedType.actualCapacity)
        cell.configure(with: input)
        return cell
    }
}

extension FeedTypesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedType = viewModel.feedType(at: indexPath.row)
        if tableView.isEditing {
            coordinator?.select(with: feedType)
        } else {
            coordinator?.selectFeed(with: feedType)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {(_,_,_) in
            let feedType = self.viewModel.feedType(at: indexPath.row)
            self.viewModel.delete(identifier: feedType.id)
            print("DELETE \(feedType.id)")
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
