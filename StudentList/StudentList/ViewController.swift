//
//  ViewController.swift
//  StudentList
//
//  Created by user150412 on 2/25/19.
//  Copyright © 2019 user150412. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var students=["Cameron Arrigo",
                  "Brandon Bisbano",
                  "Lindsay Braun",
                  "Timothy Burns",
                  "Andrew Cappel",
                  "James Cassidy",
                  "Henry Chen",
                  "Daniel Cizmarik",
                  "John Connolly",
                  "Michael Cornet",
                  "Christopher Donnelly",
                  "Alessandra Escalante",
                  "Andrew Evangelista",
                  "Sanwood Gim",
                  "Xinran Gu",
                  "Anna Guo",
                  "Annika Hall",
                  "Hongyi He",
                  "Kenyan Houck",
                  "Xiaoyu Hu",
                  "Alex Karacaoglu",
                  "Michael Kelley",
                  "Donghyuk Kim",
                  "Sarah Kim",
                  "Christopher Knapp",
                  "Thomas Kotopoulos",
                  "Mark Lee",
                  "Jack Leetch",
                  "Richard Li",
                  "Jiaxin Liang",
                  "Kejun Liu",
                  "Blake Mazzaferro",
                  "Alberto Medina",
                  "Joseph Parks",
                  "Kelly Pickreign",
                  "Thomas Ronan",
                  "Jun Shan",
                  "James Steele",
                  "Jason Tee",
                  "Jianxin Wang",
                  "Tion Wong",
                  "Victoria Wong",
                  "Timothy Yang",
                  "David Yepez",
                  "Eric Zhou"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        	
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("numberOfRowsInSection was called and there are \(students.count) rows inthe table views")
    return students.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell=tableView.dequeueReusableCell(withIdentifier:"Cell",for:indexPath)
    cell.textLabel?.text=students[indexPath.row]
    print("dequeing the table view cell for index path.row=\(indexPath.row) where the cell contains item\(students[indexPath.row])")
    return cell
}
}
