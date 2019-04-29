//
//  ViewController.swift
//  PartyPLanner
//
//  Created by user150412 on 2/25/19.
//  Copyright © 2019 user150412. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var supplies=["Potato Chips",
                  "Tortilla Chips",
                  "Salsa",
                  "Chili",
                  "Punch",
                  "Sudsy Beverages",
                  "Brownies",
                  "Cupcakes",
                  "Fruit salad",
                  "Ribs",
                  "Corn bread",
                  "Macaroni Salad",
                  "Sandwich Rolls",
                  "Roast Beef",
                  "Ham",
                  "Cheese",
                  "Mayo",
                  "Mustard",
                  "Hummus",
                  "Baby carrots",
                  "Celery",
                  "Veggie Dip",
                  "Napkins",
                  "Plates & Bowls",
                  "Forks and Knives",
                  "Cups"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection was called and there are \(supplies.count) rows inthe table views")
        return supplies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier:"Cell",for:indexPath)
        cell.textLabel?.text=supplies[indexPath.row]
        print("dequeing the table view cell for index path.row=\(indexPath.row) where the cell contains item\(supplies[indexPath.row])")
        return cell
    }
}
