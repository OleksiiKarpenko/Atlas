//
//  CountryListViewController.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/15/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import UIKit
import Moya

class CountryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource = [CountryModel]()
    var region: RegionEnum = .europe
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = region.region.capitalized
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    func configure(){
        fetchCountry()
    }
    
    private func fetchCountry() {
        CountryService.shared.getCountry(region: region) { [weak self] in
            switch $0 {
            case .success(let value):
                self?.dataSource = value
                self?.tableView.reloadData()
            case .failure(let error):
                print( error.localizedDescription ) // here we can create some alert, for example
            }
        }
    }
    
    func moveToCountryDetail(indexPath:IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let countryItem = dataSource[indexPath.row]
        let vc = sb.instantiateViewController(withIdentifier: CountryDetailViewController.typeName) as! CountryDetailViewController
        vc.itemModel = countryItem
        vc.title = countryItem.countryNameLatin
        self.navigationController?.show(vc, sender: nil)
    }
    
    func getCountryFlag(country: String) -> String {
        let base: UInt32 = 127397
        return country.unicodeScalars.compactMap { String.init(UnicodeScalar(base + $0.value)!) }.joined()
    }
}

//UITableViewDelegate
extension CountryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToCountryDetail(indexPath: indexPath)
    }
}

// UITableViewDataSource
extension CountryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.typeName)
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    fileprivate func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath){
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(getCountryFlag(country: dataSource[indexPath.row].countryTwoLettersCode?.uppercased() ?? "UA")) \(dataSource[indexPath.row].countryNameLatin ?? "") / \((dataSource[indexPath.row].countryNameNative ?? ""))"
    }
}
