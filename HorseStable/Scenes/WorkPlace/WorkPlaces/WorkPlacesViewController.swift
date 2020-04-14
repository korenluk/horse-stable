//
//  WorkPlacesViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 11/04/2020.
//  Copyright © 2020 Lukas Korinek. All rights reserved.
//

import UIKit

protocol WorkPlacesViewControlling {
    var coordinator: WorkPlacesCoordinating? {get set}
}

class WorkPlacesViewController: UIViewController, WorkPlacesViewControlling {
    
    var viewModel: WorkPlacesViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var coordinator: WorkPlacesCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Work Place"
        tableView.register(WorkPlaceCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        viewModel.updateWorkPlaces()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        tableView.tableFooterView = UIView()
        tableView.allowsSelectionDuringEditing = true
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear WORK PLACE")
        viewModel.updateWorkPlaces()
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
        viewModel.updateWorkPlaces()
        tableView.reloadData()
    }
}

extension WorkPlacesViewController: WorkPlacesViewModelDelegate {
    func didUpdateWorkPlaces() {
        if viewModel.numberOfWorkPlaces() == 0 {
            let alertController = UIAlertController(title: "VOID", message: "You dont have any work place. Please add some.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ADD", style: .default) { alert in
                self.coordinator?.add()
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            present(alertController, animated: true, completion: nil)
        }
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func didDeleteWorkPlace() {
        viewModel.updateWorkPlaces()
    }
    
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension WorkPlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfWorkPlaces()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        cell.editingAccessoryType = .disclosureIndicator
        let workPlace = viewModel.workPlace(at: indexPath.row)
        cell.detailTextLabel?.text = workPlace.capacity.description
        cell.textLabel?.text = workPlace.name
        return cell
    }
}

extension WorkPlacesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workPlace = viewModel.workPlace(at: indexPath.row)
        if tableView.isEditing {
            coordinator?.select(with: workPlace)
        } else {
            coordinator?.selectWorks(with: workPlace)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {(_,_,_) in
            let WorkPlace = self.viewModel.workPlace(at: indexPath.row)
            self.viewModel.delete(identifier: WorkPlace.id)
            print("DELETE \(WorkPlace.id)")
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
