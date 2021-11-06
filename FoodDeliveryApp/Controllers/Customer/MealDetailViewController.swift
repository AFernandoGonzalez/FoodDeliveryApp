//
//  MealDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Alvaro Gonzalez on 11/4/21.
//

import UIKit
import Stripe

class MealDetailViewController: UIViewController {
    
    @IBOutlet weak var imgMeal: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealDescription: UILabel!
    @IBOutlet weak var lbQty: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    var meal: Meal?
    var restaurant: Restaurant?
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
        let cartItem = CartItem(meal: self.meal!, qty: qty)
        guard let cartRestaurant = Cart.currentCart.restaurant, let currentRestaurant = self.restaurant
        
        else {
            Cart.currentCart.restaurant = self.restaurant
            Cart.currentCart.items.append(cartItem)
            return
        }
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        //
        if cartRestaurant.id == currentRestaurant.id {
            let inCart = Cart.currentCart.items.firstIndex(where: {(item) -> Bool in
                return item.meal.id! == cartItem.meal.id!
            })
            // in case you order from a restaruant
            if let index = inCart {
                let alertView = UIAlertController(
                    title: "Add more", message: "Your tray alwaresy has this meal, add more?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Add more", style: .default, handler: {( action: UIAlertAction) in
                    Cart.currentCart.items[index].qty += self.qty
                })
                alertView.addAction(okAction)
                alertView.addAction(cancelAction)
                
                self.present(alertView, animated: true, completion: nil)
            }
            // in case you order from another restaurant
        }else {
            let alertView = UIAlertController(
                title: "Start new Order?", message: "Your are ordering a meal from another another restaurant. Clear Cart?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "New Order", style: .default, handler: {( action: UIAlertAction) in
                //empty cart first
                Cart.currentCart.items = []
                // add new meal from another restaurant
                Cart.currentCart.items.append(cartItem)
                Cart.currentCart.restaurant = self.restaurant
            })
            alertView.addAction(okAction)
            alertView.addAction(cancelAction)
            
            self.present(alertView, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    

 

}
