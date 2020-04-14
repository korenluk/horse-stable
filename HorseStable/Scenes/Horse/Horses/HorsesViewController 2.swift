//
//  HorsesViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 29/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol HorsesViewControlling {
    var coordinator: HorsesCoordinating? {get set}
}

class HorsesViewController: UIViewController, HorsesViewControlling {
    
    var viewModel: HorsesViewModel!
    
    @IBOutlet var tableView: UITableView!
    
    var coordinator: HorsesCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Horses"
        tableView.register(HorseCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        viewModel.updateHorses()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear")
        viewModel.updateHorses()
        tableView.reloadData()
    }
    
    @objc func add() {
        let capacity = UserDefaults.standard.integer(forKey: "capacity")
        if viewModel.numberOfHorses() >= capacity {
            let alertController = UIAlertController(title: "Full Capacity", message: "You cannot add more horses. Please delete some.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))

            present(alertController, animated: true, completion: nil)
        } else {
            coordinator?.add()
        }
    }
}

extension HorsesViewController: HorsesViewModelDelegate {
    func didUpdateHorses() {
        tableView.reloadData()
    }
    
    func didDeleteHorse() {
        viewModel.updateHorses()
    }
    
    func didUpdate(isBusy: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isBusy
    }
    
    func didFail(with error: Error) {
        print(error)
    }
    
    
}

extension HorsesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHorses()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let horse = viewModel.horse(at: indexPath.row)
        cell.textLabel?.text = horse.name
        //cell.detailTextLabel?.text = "Age: \(horse.age)"
        return cell
    }
    
}

extension HorsesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let horse = viewModel.horse(at: indexPath.row)
        
        coordinator?.select(with: horse)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {(_,_,_) in
            let horse = self.viewModel.horse(at: indexPath.row)
            self.viewModel.delete(identifier: horse.id)
            print("DELETE \(horse.id)")
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
