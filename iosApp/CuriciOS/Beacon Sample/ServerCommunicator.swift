//
//  ServerCommunicator.swift
//  Beacon Sample
//
//  Created by Niclas Heun on 23.11.19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class ServerCommunicator {
    var latestUUID = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
    var latestDistance = 4
    let userID = "ad4383bc-5716-481f-88a0-bf3fe565fbd5"
    let userEmail = "max@mustermann.de"
    var serverPrefix = "http://192.168.8.113:8000"
    var beaconName = ""
    //var userData: UserData
    
    func updateBeaconData(uuid: String, distance: Int){
        if(latestUUID != uuid || distance != latestDistance){
            latestDistance = distance
            latestUUID = uuid

            triggerServerUpdate()
        }
        
    }
    
    func triggerServerUpdate(){
        //API-call:
        let apiURL = "/users/beacon-update/beacon_id=\(latestUUID)/beacon_user_id=\(userID)/beacon_state=\(latestDistance)"
        callServer(apiURL: apiURL)
        print("ServerMesssage: Hello BeaconUID: \(latestUUID) with Distance \(latestDistance)")
    }
    
    func fetchInitalUserData(){
        let url = URL(string: serverPrefix + "/users/email=\(userEmail)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                    /*
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
                            if let user = json["user"] as? [String] {
                                print(user)
                            }
                            
                            if let userid =  json["user"] as? [String] {
                                print(userid)
                            }
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    */
                }
            }
        }
        task.resume()

    }
    
    func callServer(apiURL:String){
        let url = URL(string: serverPrefix + apiURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                    let start = dataString.index(dataString.startIndex, offsetBy: 11)
                    let end = dataString.index(dataString.endIndex, offsetBy: -2)
                    self.beaconName = String(dataString[start..<end])  // play
                }
            }
        }
        task.resume()
    }
    
    
    func updateUserData(disabilities: [String]){
        let json: [String: Any] = ["id": userID,
                                   "disabilities": disabilities]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let url = URL(string: serverPrefix + "/users/update-disabilities")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    }
}


