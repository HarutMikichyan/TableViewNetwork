//
//  ImagesListViewController.swift
//  TableViewNetwork
//
//  Created by Harut Mikichyan on 10/25/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    var imagesData = [ImageData]()
    var dataManager: DataManager!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataManager()
        tableView.register(UINib(nibName: ImagesListTableViewCell.id, bundle: nil), forCellReuseIdentifier: ImagesListTableViewCell.id)
        tableView.separatorStyle = .none
        
        dataManager.getImageData { [weak self] (result) in
            guard let self = self, let result = result else { return }
            self.imagesData = result
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Private Interface
    private func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    private func setupDataManager() {
        let networkManager = NetworkManager()
        dataManager = DataManager(networkManager: networkManager)
    }
}

//MARK: - TableView Delegate DataSource
extension ImagesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListTableViewCell.id, for: indexPath) as! ImagesListTableViewCell
        cell.imageID.text = imagesData[indexPath.row].imageID
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        cell.tag = indexPath.row
        
        DataStore.shared.saveImage(stringURL: imagesData[indexPath.row].stringURL) { [weak cell] (image, bool) in
            if bool {
                if let cell = cell, image != nil, cell.tag == indexPath.row {
                    cell.activityIndicator.stopAnimating()
                    cell.activityIndicator.isHidden = true
                    cell.iconImage.image = image
                }
            }
        }
        return cell
    }
}
