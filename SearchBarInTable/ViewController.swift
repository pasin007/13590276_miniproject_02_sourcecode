//
//  ViewController.swift
//  13590276TableViewContent
//
//  Created by pasin on 25/10/2561 BE.
//  Copyright © 2561 13590276. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var movieArray = [Animal]()
    var currentAnimalArray = [Animal]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimals()
        setUpSearchBar()
        alterLayout()
    }
    
    private func setUpAnimals() {
        
        movieArray.append(Animal(name: "ปลาเเซลมอน", category: .Fantasy, image:"f1"))
        movieArray.append(Animal(name: "ปลาเก๋าทะเล", category: .Monster, image:"f2"))
        movieArray.append(Animal(name: "ปลาสำลี", category: .Horror, image:"f3"))
       
        movieArray.append(Animal(name: "ปลาซาบะ", category:.scifi, image:"f4"))
        movieArray.append(Animal(name: "ปลากะพงขาว", category: .fish, image:"f5"))
        movieArray.append(Animal(name: "ปลาจะละเม็ด", category: .scifi, image:"f6"))
        currentAnimalArray = movieArray
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        
        table.estimatedSectionHeaderHeight = 50
        
        navigationItem.titleView = searchBar
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search Food by Name"
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnimalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = currentAnimalArray[indexPath.row].name
        cell.categoryLbl.text = currentAnimalArray[indexPath.row].category.rawValue
        cell.imgView.image = UIImage(named:currentAnimalArray[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.image = UIImage(named:currentAnimalArray[indexPath.row].image)!
        vc?.name = currentAnimalArray[indexPath.row].name
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentAnimalArray = movieArray.filter({ animal -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return animal.name.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return animal.category == .scifi }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                animal.category == .scifi
            case 2:
                if searchText.isEmpty { return animal.category == .Fantasy }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                animal.category == .Fantasy
            case 3:
                if searchText.isEmpty { return animal.category == .Horror }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .Horror
            case 4:
                if searchText.isEmpty { return animal.category == .Monster }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .Monster
            case 5:
                if searchText.isEmpty { return animal.category == .fish }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .fish
            default:
                return false
            }
        })
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentAnimalArray = movieArray
        case 1:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MovieType.scifi
            })
        case 2:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MovieType.Fantasy
            })
        case 3:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MovieType.Horror
            })
        case 4:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MovieType.Monster
            })
        case 5:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MovieType.fish
            })
        default:
            break
        }
        table.reloadData()
    }
}

class Animal {
    let name: String
    let image: String
    let category: MovieType
    
    
    init(name: String, category: MovieType, image: String) {
        self.name = name
        self.category = category
        self.image = image
       
    }
}

enum MovieType: String {
    case Fantasy = "520 / กิโล"
    case scifi = "90 / กิโล"
    case Horror = "380 / กิโล"
    case Monster = "310 / กิโล"
    case fish = "280 / กิโล"
}


