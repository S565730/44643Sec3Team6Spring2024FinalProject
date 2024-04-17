//
//  CategoriesVC.swift
//  AroundMe
//
//  Created by rachana on 4/12/24.
//

import UIKit
import AudioToolbox
class CategoriesVC: UIViewController {

    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var categoriesTV: UITableView!
    var allCategories: [CategoryModel] = []
    var filteredCategories: [CategoryModel] = []
    
    var selectedCategory: CategoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obj = Categories()
        self.allCategories = obj.getAllCategories()
        self.filteredCategories = self.allCategories
        
        self.categoriesTV.delegate = self
        self.categoriesTV.dataSource = self
        
        self.searchBar.delegate = self
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "categoriesToMaps" {
            AudioServicesPlaySystemSound(1302)
            let vc = segue.destination as! MapViewController
            vc.selectedCategory = self.selectedCategory
        }
    }
}

extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        
        let category = filteredCategories[indexPath.row]
        cell.iconLbl.text = category.icon
        cell.nameLbl.text = category.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCategory = self.filteredCategories[indexPath.row]
        self.performSegue(withIdentifier: "categoriesToMaps", sender: self)
    }
}

extension CategoriesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        AudioServicesPlaySystemSound(1104)
        if searchText == "" {
            
            self.filteredCategories = self.allCategories
        }else {
            
            self.filteredCategories = allCategories.filter { $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        self.categoriesTV.reloadData()
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


