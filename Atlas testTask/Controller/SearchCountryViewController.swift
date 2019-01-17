//
//  SearchCountryViewController.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/15/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import UIKit

class SearchCountryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var dataSource = [CountryModel]()
    let emptyDataSource = ["Please begin enter country name in search bar."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.navigationController?.navigationBar.topItem?.title = "Search country"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        configureSearchControll()
    }
    
    private func configureSearchControll() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search countries"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func getCountryFlag(country: String) -> String {
        let base: UInt32 = 127397
        return country.unicodeScalars.compactMap { String.init(UnicodeScalar(base + $0.value)!) }.joined()
    }
    
    func moveToCountryDetail(indexPath:IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let countryItem = dataSource[indexPath.row]
        let vc = sb.instantiateViewController(withIdentifier: CountryDetailViewController.typeName) as! CountryDetailViewController
        vc.itemModel = countryItem
        vc.title = countryItem.countryNameLatin
        self.navigationController?.show(vc, sender: nil)
    }
    
    private func searchCountryByName(text:String) {
        CountryService.shared.getCountryByName(countryName: text) { [weak self] in
            switch $0 {
            case .success(let value):
                self?.dataSource = value
                self?.tableView.reloadData()
            case .failure(let error):
                print( error.localizedDescription )
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.count > 0 {
            searchCountryByName(text: searchText)
        } else {
            dataSource.removeAll()
            tableView.reloadData()
        }
    }
}

// searchBar
extension SearchCountryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

//UITableViewDataSource
extension SearchCountryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToCountryDetail(indexPath: indexPath)
    }
}

//UITableViewDataSource
extension SearchCountryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty {
             return emptyDataSource.count
        } else {
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.typeName)
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    fileprivate func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        if dataSource.isEmpty {
            cell.textLabel?.numberOfLines = 0
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = emptyDataSource[indexPath.row]
        } else {
        cell.textLabel?.numberOfLines = 0
            cell.isUserInteractionEnabled = true
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "\(getCountryFlag(country:  dataSource[indexPath.row].countryTwoLettersCode?.uppercased() ?? "UA")) \(dataSource[indexPath.row].countryNameLatin ?? "") / \((dataSource[indexPath.row].countryNameNative ?? ""))"
        }
    }
}
