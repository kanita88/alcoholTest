//
//  AlcoolViewController.swift
//  alcoolTest
//
//  Created by etudiant-07 on 07/03/2017.
//  Copyright © 2017 Kanita. All rights reserved.
//

import UIKit

class AlcoolViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var heuresPickerView: UIPickerView!
    @IBOutlet weak var biereAddButton: UIButton!
    @IBOutlet weak var vinAddButton: UIButton!
    @IBOutlet weak var whiskyAddButton: UIButton!
    @IBOutlet weak var portoAddButton: UIButton!
    @IBOutlet weak var biereLabel: UILabel!
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var whiskyLabel: UILabel!
    @IBOutlet weak var portoLabel: UILabel!
    @IBOutlet weak var tauxAlcoolLabel: UILabel!
    @IBOutlet weak var alcoolProgressView: UIProgressView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet var supprimeButtonLabel: [UIButton]!
    
    
    
    var user = User()
    var drinks = [Drink]() //on commence avec un tableau vide
    
    var heures = ["1 heures", "2 heures", "3 heures", "4 heures","5 heures"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.heuresPickerView.dataSource = self
        self.heuresPickerView.delegate = self
        
        self.biereAddButton.layer.cornerRadius = biereAddButton.frame.size.width/2
        self.biereAddButton.clipsToBounds = true
        
        self.vinAddButton.layer.cornerRadius = vinAddButton.frame.size.width/2
        self.vinAddButton.clipsToBounds = true
        
        self.whiskyAddButton.layer.cornerRadius = whiskyAddButton.frame.size.width/2
        self.whiskyAddButton.clipsToBounds = true
        
        self.portoAddButton.layer.cornerRadius = portoAddButton.frame.size.width/2
        self.portoAddButton.clipsToBounds = true
        
        self.alcoolProgressView.transform = alcoolProgressView.transform.scaledBy(x: 1, y: 9)
        
        for button in supprimeButtonLabel{
            button.layer.cornerRadius = button.frame.size.width/1
            button.clipsToBounds = true
        }
        
        
        
        
        user.nbOfGlasses = [0,0,0,0]
    
        drinks.append(Drink(name: "Bière", alcooholRate: 0.04, glassSize: 330))
        drinks.append(Drink(name: "Vin", alcooholRate: 0.12, glassSize: 120))
        drinks.append(Drink(name: "Whisky", alcooholRate: 0.40, glassSize: 50))
        drinks.append(Drink(name: "Porto", alcooholRate: 0.18, glassSize: 80))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("poids : \(user.weight)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return heures.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return heures[row]
    }
    
    @IBAction func drinkPressed(_ sender: UIButton) {
    
     user.nbOfGlasses[sender.tag] += 1
     updateDisplay()
        
    }
    
    
    @IBAction func removePressed(_ sender: UIButton) {
        if user.nbOfGlasses[sender.tag] >= 1 {
            user.nbOfGlasses[sender.tag] -= 1
            updateDisplay()
            
        }
        
    }
    
    func updateDisplay(){
        
        biereLabel.text = "\(user.nbOfGlasses[0])"
        vinLabel.text = "\(user.nbOfGlasses[1])"
        whiskyLabel.text = "\(user.nbOfGlasses[2])"
        portoLabel.text = "\(user.nbOfGlasses[3])"
        
        let alcooltest = user.computeAlcooholRate(drinks: self.drinks)
            tauxAlcoolLabel.text = "\(alcooltest) g/l"
        
        
        let barProgress = Float(user.computeAlcooholRate(drinks: self.drinks)/maxAlcooholRate)
            
        alcoolProgressView.setProgress(barProgress, animated: true)
        
        if  user.computeAlcooholRate(drinks: self.drinks) >= firstAlcooholRate {
            alcoolProgressView.progressTintColor = UIColor.orange
          }
        }
    
    @IBAction func profileButtonPressed(_ sender: UIBarButtonItem) {
        
        print("button profile pressed")
        
        self.performSegue(withIdentifier: "mainToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToProfile" {
            if let destinationVc = segue.destination as? ProfilViewController{
                destinationVc.user = self.user
            }
        }
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        for index in 0...3{
            user.nbOfGlasses[index] = 0
        }
        updateDisplay()
    }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
