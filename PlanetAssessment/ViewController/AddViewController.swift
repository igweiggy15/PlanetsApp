//
//  AddViewController.swift
//  PlanetApp
//
//
//

import UIKit

class AddViewController: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var planetTextField: UITextField!
    @IBOutlet weak var moonTextField: UITextField!
    
    //MARK: Properties
    var viewModel: ViewModel!
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBActions
    @IBAction func buttonTouched(_ sender: Any) {
        
        if let planetInput = planetTextField.text, let moonInput = moonTextField.text, let moonCount = Int(moonInput){
            
            if planetInput.count > 0 && moonCount < 3 {
                
                viewModel.addPlanet(Planet(name: planetInput, moons: moonCount))
                
                let planetVC = storyboard?.instantiateViewController(withIdentifier: "PlanetViewController") as! PlanetViewController
                planetVC.hidesBottomBarWhenPushed = true
                navigationController?.view.backgroundColor = .white
                present(planetVC, animated: true, completion: nil)
                
            } else {
                let alert = UIAlertController(title: "Too many moons you need less than 3 moons", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
