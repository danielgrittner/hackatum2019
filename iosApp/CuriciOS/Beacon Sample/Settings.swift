//
//  Settings.swift
//  Beacon Sample
//
//  Created by Niclas Heun on 23.11.19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class Settings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var lineChange: UIStepper!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

    }
    
    // MARK: - Table View Data Source
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "title"
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

            // Display the UUID, major, and minor for each beacon.
    //        let sectionkey = Array(beacons.keys)[indexPath.section]
    //        //let beacon = beacons[sectionkey]![indexPath.row]
        
            cell.textLabel?.text = "Trallal"
            cell.detailTextLabel?.text = "Billala"
            

            //print("Here is the fucking information for you daniel !!!")
            //print( "UUID: \(beacon.uuid.uuidString)")
            //print("Distance: \(beacon.proximity.rawValue)")
            return cell
        }
}


