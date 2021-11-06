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
    @IBOutlet weak var lbQty: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    var meal: Meal?
    var qty = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMeal()
        // Do any additional setup after loading the view.
    }
    
    
    func loadMeal() {
        //
        if let price = meal?.price {
            lbTotal.text = "$\(price)"
        }
        
        
        mealName.text = meal?.name
        mealDescription.text = meal?.short_description
        
        if let imageUrl = meal?.image {
            Helpers.loadImage(imgMeal, "\(imageUrl)")
        }
        
    }
    
    
    
    
    //
    
    @IBAction func removeQty(_ sender: Any) {
        if qty >= 2 {
            qty -= 1
            lbQty.text = String(qty)
            
            if let price = meal?.price {
                lbTotal.text = "$\(price * Float(qty))"
            }
        }
    }
    
    @IBAction func addQty(_ sender: Any) {
        if qty < 99 {
            qty += 1
            lbQty.text = String(qty)
            
            if let price = meal?.price {
                lbTotal.text = "$\(price * Float(qty))"
            }
        }
    
    }
    
    @IBAction func addToCart(_ sender: Any) {
    }
    
    
    
    
    

 

}
