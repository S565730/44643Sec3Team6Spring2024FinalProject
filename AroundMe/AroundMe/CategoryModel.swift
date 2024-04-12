//
//  CategoryModel.swift
//  AroundMe
//
//  Created by Rachana on 30/03/2024.
//

import Foundation

struct CategoryModel {
    
    var title: String = ""
    var key: String = ""
    var icon: String = ""
    
    init() {}
}


class Categories {
    
    func getAllCategories() -> [CategoryModel] {
        
        var categories: [CategoryModel] = []
        
        var cat = CategoryModel()
        
        cat.title = "Restaurants"
        cat.key = "restaurant"
        cat.icon = "🍽️"
        categories.append(cat)
        
        
        cat.title = "Grocery Stores"
        cat.key = "grocery_or_supermarket"
        cat.icon = "🛒"
        categories.append(cat)
        
        
        cat.title = "Gas Stations"
        cat.key = "gas_station"
        cat.icon = "⛽"
        categories.append(cat)
        
        
        cat.title = "Pharmacies"
        cat.key = "pharmacy"
        cat.icon = "💊"
        categories.append(cat)
        
        
        cat.title = "Banks"
        cat.key = "bank"
        cat.icon = "🏦"
        categories.append(cat)
        
        
        cat.title = "Hospitals"
        cat.key = "hospital"
        cat.icon = "🏥"
        categories.append(cat)
        
        
        cat.title = "Parks"
        cat.key = "park"
        cat.icon = "🌳"
        categories.append(cat)
        
        
        cat.title = "Schools"
        cat.key = "school"
        cat.icon = "🏫"
        categories.append(cat)
        
        
        cat.title = "Gyms"
        cat.key = "gym"
        cat.icon = "🏋️‍♂️"
        categories.append(cat)
        
        
        cat.title = "Churches"
        cat.key = "church"
        cat.icon = "⛪"
        categories.append(cat)
        
        
        cat.title = "Bookstores"
        cat.key = "bookstore"
        cat.icon = "📚"
        categories.append(cat)
        
        
        
        cat.title = "Clothing Stores"
        cat.key = "clothing_store"
        cat.icon = "👕"
        categories.append(cat)
        
        
        
        cat.title = "Cinemas"
        cat.key = "movie_theater"
        cat.icon = "🎥"
        categories.append(cat)
        
        
        
        cat.title = "Offices"
        cat.key = "post_office"
        cat.icon = "📮"
        categories.append(cat)
        
        
        cat.title = "Libraries"
        cat.key = "library"
        cat.icon = "📚"
        categories.append(cat)
        
        
        
        cat.title = "Airports"
        cat.key = "airport"
        cat.icon = "🛫"
        categories.append(cat)
        
        
        
        cat.title = "Train Stations"
        cat.key = "train_station"
        cat.icon = "🚉"
        categories.append(cat)
        
        
        
        cat.title = "Car Rental Agencies"
        cat.key = "car_rental"
        cat.icon = "🚗"
        categories.append(cat)
        
        
        
        cat.title = "Hair Salons"
        cat.key = "hair_care"
        cat.icon = " 💇"
        categories.append(cat)
        
        
        cat.title = "Coffee Shops"
        cat.key = "cafe"
        cat.icon = "☕"
        categories.append(cat)
        
        
        return categories
    }
}
        
