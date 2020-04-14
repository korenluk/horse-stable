//
//  StablesViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 20/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol StablesViewControlling {
    var done: (() -> Void)? { get set }
    var coordinator: StablesCoordinating? {get set}
}

class StablesViewController: UIViewController, StablesViewControlling {
    var done: (() -> Void)?
    
    var viewModel: StablesViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinator: StablesCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateStables()
        navigationItem.title = "Stable"
        viewModel.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        tableView.register(HorseWorksCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear STABLE")
        viewModel.updateStables()
        tableView.reloadData()
    }
    
    @objc func add() {
        coordinator?.add()
    }
}

extension StablesViewController: StablesViewModelDelegate {
    func didUpdateStables() {
        if viewModel.stables.isEmpty{
            add()
        } else if viewModel.stables.count == 1{
            done?()
        } else {
            tableView.reloadData()
        }
    }
    
    func didUpdate(isBusy: Bool) {
        
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension StablesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stable = viewModel.stable(at: indexPath.row)
        UserDefaults.standard.set(stable.id, forKey: "stableID")
        UserDefaults.standard.set(stable.capacity, forKey: "capacity")
        done?()
    }
}

extension StablesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfStables()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let stable = viewModel.stable(at: indexPath.row)
        cell.textLabel?.text = stable.name
        cell.detailTextLabel?.text = "capacity: \(stable.capacity)"
        return cell
    }
}
