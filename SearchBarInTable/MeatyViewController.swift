//
//  MeatyViewController.swift
//  SearchBarInTable
//
//  Created by pasin on 17/11/2561 BE.
//  Copyright © 2561 Xiaodan Wang. All rights reserved.
//

import UIKit

class MeatyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    var mnovieArray = [Aaanimal]()
    var currentAnimalArray = [Aaanimal]()

    override func viewDidLoad() {
        super.viewDidLoad()
              setUpAnimals()
              setUpSearchBar()
              alterLayout()

        // Do any additional setup after loading the view.
    }
    private func setUpAnimals() {
        
        mnovieArray.append(Aaanimal(name: "สันใน", category: .Fantasy, image:"m1"))
        mnovieArray.append(Aaanimal(name: "สันนอก", category: .Fantasy, image:"m2"))
        mnovieArray.append(Aaanimal(name: "สันคอ", category: .scifi, image:"m3"))
        
        mnovieArray.append(Aaanimal(name: "สามชั้น", category:.Fantasy, image:"m4"))
        mnovieArray.append(Aaanimal(name: "ซี่โครง", category: .Monster, image:"m5"))
        mnovieArray.append(Aaanimal(name: "ขาหมู", category: .scifi, image:"m6"))
        //        mnovieArray.append(Aanimal(name: "Annihilation", category: .scifi , image:"7"))
        //        mnovieArray.append(Aanimal(name: "Rampage", category: .Monster, image:"8"))
        //        mnovieArray.append(Aanimal(name: "Pacific Rim", category: .Monster, image:"9"))
        //        mnovieArray.append(Aanimal(name: "Antman", category: .Fantasy, image:"10"))
        
        currentAnimalArray = mnovieArray
    }
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout(){
        table.tableHeaderView = UIView()
        table.estimatedSectionHeaderHeight = 50
        
        navigationItem.titleView = searchBar
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search Meat by name"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnimalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else{
            return UITableViewCell()
        }
        cell.nameLbl.text = currentAnimalArray[indexPath.row].name
        cell.categoryLbl.text = currentAnimalArray[indexPath.row].category.rawValue
        cell.imgView.image = UIImage(named: currentAnimalArray[indexPath.row].image)
        return cell
    }
    func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.image = UIImage(named:currentAnimalArray[indexPath.row].image)!
        vc?.name = currentAnimalArray[indexPath.row].name
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    //Search Bar
    func searchBar(_ search: UISearchBar, textDidChange searchText:String){
        currentAnimalArray = mnovieArray.filter({ animal -> Bool in switch searchBar.selectedScopeButtonIndex{
        case 0:
            if searchText.isEmpty{return true}
            return
                animal.name.lowercased().contains(searchText.lowercased())
        case 1:
            if searchText.isEmpty{ return animal.category == .scifi}
            return
                animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .scifi
        case 2:
            if searchText.isEmpty{ return animal.category == .Fantasy}
            return
                animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .Fantasy
        case 3:
            if searchText.isEmpty{ return animal.category == .Horror}
            return
                animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .Horror
        case 4:
            if searchText.isEmpty{ return animal.category == .Monster}
            return
                animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .Monster
        default:
            return false
            
            }
        })
        table.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar,selectedScopeButtonIndexDidChange selectedScope: Int){
        switch selectedScope {
        case 0:
            currentAnimalArray = mnovieArray
        case 1:
            currentAnimalArray = mnovieArray.filter({ animal -> Bool in animal.category == MmmovieType.scifi})
        case 2:
            currentAnimalArray = mnovieArray.filter({ animal -> Bool in animal.category == MmmovieType.Fantasy})
        case 3:
            currentAnimalArray = mnovieArray.filter({ animal -> Bool in animal.category == MmmovieType.Horror})
        case 4:
            currentAnimalArray = mnovieArray.filter({ animal -> Bool in animal.category == MmmovieType.Monster})
        default:
            break
        }
        table.reloadData()
    }

    

}
class Aaanimal {
    let name: String
    let image:  String
    let category: MmmovieType
    init(name: String, category: MmmovieType, image: String) {
        self.name = name
        self.category = category
        self.image = image
    }
    
}
enum MmmovieType: String {
    case Fantasy = "120 / กิโล"
    case scifi = "140 / กิโล"
    case Horror = "146 / กิโล"
    case Monster = "155 / กิโล"
}
