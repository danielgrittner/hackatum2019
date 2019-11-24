//
//  BeaconCommunicator.swift
//  Beacon Sample
//
//  Created by Niclas Heun on 23.11.19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class BeaconCommunicator : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var triggerButton: UIButton!
    @IBOutlet weak var beaconImage: UIImageView!
    
    var triggerActivated = true
    var sendDisableMessage = false
    
    let defaultUUID = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
    let server = ServerCommunicator.init()
    
    var locationManager = CLLocationManager()
    var beaconConstraints = [CLBeaconIdentityConstraint: [CLBeacon]]()
    var beacons = [CLProximity: [CLBeacon]]()
    var lastuuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        server.fetchInitalUserData()
        server.triggerServerUpdate()
           locationManager.delegate = self
           //adding Beacon UUID - self-written+
           addBeacon(self)

       }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Stop monitoring when the view disappears.
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        
        // Stop ranging when the view disappears.
        for constraint in beaconConstraints.keys {
            locationManager.stopRangingBeacons(satisfying: constraint)
            }
        
    }
    
    
    @IBAction func addBeacon(_ sender: Any) {
           let uuidString = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
           let uuid = UUID(uuidString: uuidString)!
           self.locationManager.requestWhenInUseAuthorization()
                       
           // Create a new constraint and add it to the dictionary.
           let constraint = CLBeaconIdentityConstraint(uuid: uuid)
           self.beaconConstraints[constraint] = []
                       
                       /*
                       By monitoring for the beacon before ranging, the app is more
                       energy efficient if the beacon is not immediately observable.
                       */
           let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: uuid.uuidString)
           self.locationManager.startMonitoring(for: beaconRegion)
       }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
         let beaconRegion = region as? CLBeaconRegion
         if state == .inside {
             // Start ranging when inside a region.
             manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
         } else {
             // Stop ranging when not inside a region.
             manager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
         }
     }
     
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        /*
         Beacons are categorized by proximity. A beacon can satisfy
         multiple constraints and can be displayed multiple times.
         */
        beaconConstraints[beaconConstraint] = beacons
        
        self.beacons.removeAll()
        
        var allBeacons = [CLBeacon]()
        
        for regionResult in beaconConstraints.values {
            allBeacons.append(contentsOf: regionResult)
        }
        
        for range in [CLProximity.unknown, .immediate, .near, .far] {
            let proximityBeacons = allBeacons.filter { $0.proximity == range }
            if !proximityBeacons.isEmpty {
                self.beacons[range] = proximityBeacons
            }
        }
        
        reloadData()
    }
    
    func reloadData(){
        
        if(!triggerActivated){
            uuidLabel.text = "Triggering deactivated"
            uuidLabel.textColor = UIColor.red
            distanceLabel.text = "--"
            if(Array(beacons.keys).count > 0 && !sendDisableMessage){
                let sectionkey = Array(beacons.keys)[0]
                let beacon = beacons[sectionkey]![0]
                
                server.updateBeaconData(uuid: beacon.uuid.uuidString, distance: 4)
                
                sendDisableMessage = true
            }
            return
        }
        //TODO: INDEX out of bound
        if(Array(beacons.keys).count > 0){
            let sectionkey = Array(beacons.keys)[0]
            let beacon = beacons[sectionkey]![0]
            
            server.updateBeaconData(uuid: beacon.uuid.uuidString, distance: beacon.proximity.rawValue)
            //uuidLabel.text = "\(server.beaconName)"
            uuidLabel.textColor = UIColor.white
            if(lastuuid != ""){
               
                uuidLabel.text = lastuuid
            }else{
                 uuidLabel.text = "\(server.beaconName)"
                lastuuid = server.beaconName
            }
           
            
            switch beacon.proximity.rawValue {
            case 0:
                distanceLabel.text = "Unkown"
            case 1:
                distanceLabel.text = "Immediate"
            case 2:
                distanceLabel.text = "Near"
                
            case 3:
                distanceLabel.text = "Far"
            default:
                distanceLabel.text = "Unkown"
            }
            //distanceLabel.text = "\(beacon.proximity.rawValue)"
            
           
            
            
        }else{
            uuidLabel.text = "not nearby beacon"
            uuidLabel.textColor = UIColor.red
            distanceLabel.text = "--"
        }
        
        
        
    }
    @IBAction func deactiveTrigger(_ sender: Any) {
        if(triggerActivated){
            triggerButton.setTitle("Activate Trigger", for: .normal)
            beaconImage.image = UIImage(named: "Beacon_grey")
            sendDisableMessage = false
        

        }else{
            triggerButton.setTitle("Deactivate Trigger", for: .normal)
            beaconImage.image = UIImage(named: "Beacon_blue")
            //server.triggerServerUpdate()
        }
        
        triggerActivated = !triggerActivated
        reloadData()
    
    }
}
