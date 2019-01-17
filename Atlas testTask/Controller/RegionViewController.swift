//
//  ViewController.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/14/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import UIKit

// enums for easy setup table view cells

enum RegionViewControllerSectionType: Int, CaseIterable {
    
    case standart
    
    var items: [RegionViewControllerItemType] {
        switch self {
        case .standart: return [.europe, .oceania, .africa, .asia, .americas]
        }
    }
}

enum RegionViewControllerItemType {
    case europe
    case oceania
    case africa
    case asia
    case americas
    
    var identifier: String { return UITableViewCell.typeName }
    
    var title: String {
        switch self {
        case .europe:   return "Europe"
        case .oceania:  return "Oceania"
        case .africa:   return "Africa"
        case .asia:     return "Asia"
        case .americas: return "South America/North America"
        }
    }
}

class RegionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    func configure() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        configureTableView()
    }
    
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.typeName)
    }
    
    func moveToTheCountryList (choosedRegion: RegionEnum){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: CountryListViewController.typeName) as! CountryListViewController
        vc.region = choosedRegion
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.show(vc, sender: nil)
    }
}

// UITableViewDelegate:
extension RegionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = RegionViewControllerSectionType.allCases[indexPath.section]
        let itemType = sectionType.items[indexPath.row]
        
        switch itemType {
            
        case .europe:   moveToTheCountryList(choosedRegion: .europe)
        case .oceania:  moveToTheCountryList(choosedRegion: .oceania)
        case .africa:   moveToTheCountryList(choosedRegion: .africa)
        case .asia:     moveToTheCountryList(choosedRegion: .asia)
        case .americas: moveToTheCountryList(choosedRegion: .americas)
        }
    }
}

// UITableViewDataSource
extension RegionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return RegionViewControllerSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionType = RegionViewControllerSectionType.allCases[section]
        return sectionType.items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = RegionViewControllerSectionType.allCases [indexPath.section]
        let itemType = sectionType.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: itemType.identifier, for: indexPath)
        
        configureCell(cell, atIndexPath: indexPath, ofType: itemType)
        
        return cell
    }
    
    fileprivate func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath, ofType type: RegionViewControllerItemType) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = type.title
    }
}

