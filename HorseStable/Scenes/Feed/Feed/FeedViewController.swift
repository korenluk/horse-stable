//
//  FeedViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 15/03/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol FeedViewControlling {
    var coordinator: FeedCoordinating? {get set}
}

class FeedViewController: UIViewController, FeedViewControlling {
    
    var viewModel: FeedViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var coordinator: FeedCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed"
        tableView.register(FeedCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        viewModel.updateFeed()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear FEEDS")
        viewModel.updateFeed()
        tableView.reloadData()
    }
    
    @objc func add() {
        coordinator?.add()
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func didUpdateFeed() {
        if viewModel.numberOfFeed() == 0 {
            let alertController = UIAlertController(title: "VOID", message: "You dont have any feed. Please add some.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ADD", style: .default) { alert in
                self.coordinator?.add()
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            present(alertController, animated: true, completion: nil)
        }
        tableView.reloadData()
    }
    
    func didDeleteFeed() {
        viewModel.updateFeed()
    }
    
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFeed()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let feed = viewModel.feed(at: indexPath.row)
        cell.textLabel?.text = feed.name
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedType = viewModel.feed(at: indexPath.row)
        coordinator?.select(with: feedType)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {(_,_,_) in
            let feedType = self.viewModel.feed(at: indexPath.row)
            self.viewModel.delete(identifier: feedType.id)
            print("DELETE \(feedType.id)")
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
