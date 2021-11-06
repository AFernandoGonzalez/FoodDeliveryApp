//
//  MealDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Alvaro Gonzalez on 11/4/21.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    @IBOutlet weak var imgMeal: UIImageView!
    
    @IBOutlet weak var mealName: UILabel!
    
    @IBOutlet weak var mealDescription: UILabel!
    
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMeal()
        // Do any additional setup after loading the view.
    }
    
    
    func loadMeal() {
        mealName.text = meal?.name
        mealDescription.text = meal?.short_description
        
        if let imageUrl = meal?.image {
            Helpers.loadImage(imgMeal, "\(imageUrl)")
        }
        
    }
    

 

}
