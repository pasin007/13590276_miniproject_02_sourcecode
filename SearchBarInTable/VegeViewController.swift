//
//  VegeViewController.swift
//  SearchBarInTable
//
//  Created by pasin on 17/11/2561 BE.
//  Copyright © 2561 Xiaodan Wang. All rights reserved.
//

import UIKit

class VegeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    var movieArray = [Annimal]()
    var currentAnimalArray = [Annimal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimals()
        setUpSearchBar()
        alterLayout()
        // Do any additional setup after loading the view.
    }
    private func setUpAnimals() {
        
        movieArray.append(Annimal(name: "ใบโหระพา", category: .Fantasy, image:"v1"))
        movieArray.append(Annimal(name: "กะหล่ำปลี", category: .Monster, image:"v2"))
        movieArray.append(Annimal(name: "มะเขือเทศราชินี", category: .Horror, image:"v3"))
        
        movieArray.append(Annimal(name: "มะนาว", category:.scifi, image:"v4"))
        movieArray.append(Annimal(name: "บล็อคโคลี่", category: .fish, image:"v5"))
        movieArray.append(Annimal(name: "ผักสลัดแก้ว", category: .scifi, image:"v6"))
        //        movieArray.append(Animal(name: "Annihilation", category: .scifi , image:"7"))
        //        movieArray.append(Animal(name: "Rampage", category: .Monster, image:"8"))
        //        movieArray.append(Animal(name: "Pacific Rim", category: .Monster, image:"9"))
        //        movieArray.append(Animal(name: "Antman", category: .Fantasy, image:"10"))
        
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
                animal.category == MoovieType.scifi
            })
        case 2:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MoovieType.Fantasy
            })
        case 3:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MoovieType.Horror
            })
        case 4:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MoovieType.Monster
            })
        case 5:
            currentAnimalArray = movieArray.filter({ animal -> Bool in
                animal.category == MoovieType.fish
            })
        default:
            break
        }
        table.reloadData()
    }

}
class Annimal {
    let name: String
    let image: String
    let category: MoovieType
    
    
    init(name: String, category: MoovieType, image: String) {
        self.name = name
        self.category = category
        self.image = image
        
    }
}

enum MoovieType: String {
    case Fantasy = "90 / กิโลกรัม"
    case scifi = "90 / กิโล"
    case Horror = "80 / กิโลกรัม"
    case Monster = "60 / กิโลกรัม"
    case fish = "75 / กิโล"
}
