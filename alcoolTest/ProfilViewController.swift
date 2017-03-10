//
//  ProfilViewController.swift
//  alcoolTest
//
//  Created by etudiant-07 on 07/03/2017.
//  Copyright © 2017 Kanita. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var poidsPickerView: UIPickerView!
    @IBOutlet weak var poidsKgLabel: UILabel!
    @IBOutlet weak var hommeFemmeSegment: UISegmentedControl!
    
    var poids: [Int] = Array(40...100)
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.poidsPickerView.dataSource = self
        self.poidsPickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hommeFemmeSegment.selectedSegmentIndex = user.gender.rawValue
        self.poidsPickerView.selectRow(user.weight - 40 , inComponent: 0, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return poids.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(poids[row])"
        
    }
    
    @IBAction func hommeFemmeSegmentControl(_ sender: UISegmentedControl) {
         if (self.hommeFemmeSegment.selectedSegmentIndex) == 1 {
            user.gender = Gender.woman
        }
         else {
            user.gender = Gender.man
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        user.weight = 40 + poidsPickerView.selectedRow(inComponent: 0)
    }
    
    //poidsKgLabel.textLabel.text = poids[IndexPath.row]

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
