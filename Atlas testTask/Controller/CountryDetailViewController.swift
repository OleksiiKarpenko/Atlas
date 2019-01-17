//
//  CountryDetailViewController.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/15/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var itemModel = CountryModel()
    var dataSource = [CountryModel]()
    var previusCountryName: String?
    var emptyDataSource = ["This country is alone and has no neighbors"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

        getCountrysByCode(countryCode: itemModel.countryBorders?.joined(separator: ";") ?? "")
        flagLabel.text = getCountryFlag(country: itemModel.countryTwoLettersCode!)
        infoLabel.text = "\(itemModel.countryNameLatin ?? "") \nCurrency: \(itemModel.countryCurrency?.map({$0.name ?? ""}).joined(separator: ", ") ?? "") \nLanguages: \(itemModel.countryLanguages?.map({$0.name ?? ""}).joined(separator: ", ") ?? "")"
    }
    
    
    func getCountryFlag(country: String) -> String {
        let base: UInt32 = 127397
        return country.unicodeScalars.compactMap { String.init(UnicodeScalar(base + $0.value)!) }.joined()
    }
    
    func getCountrysByCode(countryCode: String) {
        
        CountryService.shared.getCountryByCode(countryCode: countryCode) { [weak self] in
            guard  let `self` = self else {return}
            switch $0 {
            case .success(let value):
                self.dataSource = value
                self.tableView.reloadData()
            case .failure(let error):
                print( error.localizedDescription )
            }
        }
    }
    
    func moveToCountryDetail(indexPath:IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let countryItem = dataSource[indexPath.row]
        if previusCountryName == countryItem.countryNameLatin {
            self.navigationController?.popViewController(animated: true)
        } else {
        let vc = sb.instantiateViewController(withIdentifier: CountryDetailViewController.typeName) as! CountryDetailViewController
        vc.itemModel = countryItem
        vc.title = countryItem.countryNameLatin
        vc.previusCountryName = itemModel.countryNameLatin
        self.navigationController?.show(vc, sender: nil)
        }
    }
}

//UITableViewDataSource

extension CountryDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToCountryDetail(indexPath: indexPath)
    }
}


// UITableViewDataSource
extension CountryDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RegionViewControllerSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty {
            return emptyDataSource.count
        } else {
            return  dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.typeName)
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    fileprivate func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath){
        if dataSource.isEmpty {
            cell.textLabel?.numberOfLines = 0
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = emptyDataSource[indexPath.row]
            cell.textLabel?.isEnabled = true
        } else {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "\(getCountryFlag(country: dataSource[indexPath.row].countryTwoLettersCode ?? "")) \(dataSource[indexPath.row].countryNameLatin ?? "") / \(dataSource[indexPath.row].countryNameNative ?? "")"
        }
    }
}
