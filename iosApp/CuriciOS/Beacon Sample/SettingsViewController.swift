/*
See LICENSE folder for this sample’s licensing information.

Abstract:
View controller that illustrates how to start and stop ranging for a beacon region.
*/

import UIKit
import CoreLocation

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    
    static var isSelcted = [false, false, false, false, false, false]
    static var supportedDisabilities = ["Asthma", "Autism",  "Diabetes", "Epilepsy", "Parkinson", "Thrombosis"]
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var tableView: UITableView!
    
    var illnesses = [5]
    
    let server = ServerCommunicator.init()
    
    /**
     This hardcoded UUID appears by default in the ranging prompt.
     It is the same UUID used in ConfigureBeaconViewController
     for creating a beacon.
     */
    
    /// This location manager is used to demonstrate how to range beacons.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding Beacon UUID - self-written+
       
        for x in 0...illnesses.count-1{
            SettingsViewController.isSelcted[(illnesses[x])] = true
        }
        
        tableView.reloadData()
        updateTable()

    }
    
    override func viewDidAppear(_ animated: Bool){
        updateTable()
    }
    
    func updateTable(){
        let oldIllnesses = illnesses
        illnesses = []
        for x in 0...SettingsViewController.isSelcted.count-1{
            if(SettingsViewController.isSelcted[x]){
                illnesses.append(x)
            }
        }
        
        if(oldIllnesses != illnesses){
            var illnessesString = [String]()
            for x in 0...illnesses.count-1{
                illnessesString.append(SettingsViewController.supportedDisabilities[illnesses[x]])
            }
            
            print("\(illnessesString)")
            server.updateUserData(disabilities: illnessesString)
        }
        
        tableView.reloadData()
    }
    
    @IBAction func addDisability(_ sender: Any) {
      /*
        let alert = UIAlertController(title: "Add new Disability",
                                      message: "Enter Name",
                                      preferredStyle: .alert)
        
        var disabilityTextField: UITextField!
        
        alert.addTextField { textField in
            textField.placeholder = "XXXXXXXX"
            disabilityTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { alert in
            if let disabilityString = disabilityTextField.text {
                self.illnesses.append(disabilityString)
                self.tableView.reloadData()

                
                
            } else {
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true)

         */
        
        print("\(stepper.value)")
        performSegue(withIdentifier: "selectSegue", sender: self)

    }
    

    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Disabilities"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return illnesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
         //let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! customCell
        // Display the UUID, major, and minor for each beacon.
//        let sectionkey = Array(beacons.keys)[indexPath.section]
//        //let beacon = beacons[sectionkey]![indexPath.row]
        
        cell.textLabel?.text = SettingsViewController.supportedDisabilities[illnesses[indexPath.row]]
        cell.detailTextLabel?.text = SettingsViewController.supportedDisabilities[illnesses[indexPath.row]]
        //cell.dayLabel.text = SettingsViewController.supportedDisabilities[illnesses[indexPath.row]]

        //print("Here is the fucking information for you daniel !!!")
        //print( "UUID: \(beacon.uuid.uuidString)")
        //print("Distance: \(beacon.proximity.rawValue)")
        return cell
    }

}
