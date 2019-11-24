//
//  Selector.swift
//  Beacon Sample
//
//  Created by Niclas Heun on 23.11.19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
class Selector: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding Beacon UUID - self-written+
        
        for x in 0...5{
            print("\(SettingsViewController.isSelcted[x])")
            if SettingsViewController.isSelcted[x]{
                disableButtons(index: x)
            }
        }
       
    }
    
    func disableButtons(index: Int){
        switch index {
            case 0:
            button1.setBackgroundImage( UIImage(named: "selection_off"), for: .normal)
            case 1:
            button2.setBackgroundImage( UIImage(named: "selection_off"), for: .normal)
            case 2:
            button3.setBackgroundImage( UIImage(named: "selection_off"), for: .normal)
            case 3:
            button4.setBackgroundImage( UIImage(named: "selection_off"), for: .normal)
            case 4:
            button5.setBackgroundImage( UIImage(named: "selection_off"), for: .normal)
            case 5:
            button6.setBackgroundImage( UIImage(named: "selection_off"), for: .normal)

            default:
                break
        }
    
        
    }
    
    func enableButtons(index: Int){
    switch index {
        case 0:
        button1.setBackgroundImage( UIImage(named: "selection_on"), for: .normal)
        case 1:
        button2.setBackgroundImage( UIImage(named: "selection_on"), for: .normal)
        case 2:
        button3.setBackgroundImage( UIImage(named: "selection_on"), for: .normal)
        case 3:
        button4.setBackgroundImage( UIImage(named: "selection_on"), for: .normal)
        case 4:
        button5.setBackgroundImage( UIImage(named: "selection_on"), for: .normal)
        case 5:
        button6.setBackgroundImage( UIImage(named: "selection_on"), for: .normal)
        default:
            break
        }
        
    }
    
    @IBAction func button1(_ sender: Any) {
        if(SettingsViewController.isSelcted[0]){
            enableButtons(index: 0)
            
        }else{
             disableButtons(index: 0)
        }
        
        SettingsViewController.isSelcted[0]  = !SettingsViewController.isSelcted[0]
        
    }
    

    @IBAction func button2(_ sender: Any) {
        if(SettingsViewController.isSelcted[1]){
            enableButtons(index: 1)
                   
        }else{
            disableButtons(index: 1)
        }
               
        SettingsViewController.isSelcted[1]  = !SettingsViewController.isSelcted[1]
    }
    
    @IBAction func button3(_ sender: Any) {
        if(SettingsViewController.isSelcted[2]){
            enableButtons(index: 2)
                   
        }else{
            disableButtons(index: 2)
        }
               
        SettingsViewController.isSelcted[2]  = !SettingsViewController.isSelcted[2]
    }
    
    @IBAction func button4(_ sender: Any) {
         if(SettingsViewController.isSelcted[3]){
            enableButtons(index: 3)
                   
        }else{
            disableButtons(index: 3)
        }
               
        SettingsViewController.isSelcted[3]  = !SettingsViewController.isSelcted[3]
    }
    
    @IBAction func button5(_ sender: Any) {
         if(SettingsViewController.isSelcted[4]){
            enableButtons(index: 4)
                   
        }else{
            disableButtons(index: 4)
        }
               
        SettingsViewController.isSelcted[4]  = !SettingsViewController.isSelcted[4]
    }
    
    @IBAction func button6(_ sender: Any) {
         if(SettingsViewController.isSelcted[5]){
            enableButtons(index: 5)
                   
        }else{
            disableButtons(index: 5)
        }
        SettingsViewController.isSelcted[5]  = !SettingsViewController.isSelcted[5]
    }
    
}
