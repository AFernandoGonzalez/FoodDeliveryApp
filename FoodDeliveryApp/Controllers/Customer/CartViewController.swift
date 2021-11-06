//
//  CartViewController.swift
//  FoodDeliveryApp
//
//  Created by Alvaro Gonzalez on 11/5/21.
//

import UIKit
import MapKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //TableView as tbvCart
    @IBOutlet weak var tbvCart: UITableView!
        
    //cart views
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewMap: UIView!
    
    //Cart labels
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelAddress: UITextField!
    @IBOutlet weak var labelMap: MKMapView!
    @IBOutlet weak var paymentButton: UIButton!
    
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tbvCart.dataSource = self
        tbvCart.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
        
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
