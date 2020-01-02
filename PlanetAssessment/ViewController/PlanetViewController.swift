//
//  ViewController.swift
//  PlanetApp
//
//
//

import UIKit

class PlanetViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var planetTableView: UITableView!
    
    //MARK: Properties
    let viewModel = ViewModel()
    
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlanets()
    }
    
    //MARK: IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        let addVC = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        addVC.viewModel = viewModel
        present(addVC, animated: true, completion: nil)
    }

    //MARK: Functions
    private func setupPlanets() {
        planetTableView.tableFooterView = UIView(frame: .zero)
        planetTableView.separatorStyle = .none
        viewModel.delegate = self
        viewModel.planets = CoreManager.shared.load()
    }
}

extension PlanetViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanetTableCell.identifier, for: indexPath) as! PlanetTableCell
        let planet = viewModel.planets[indexPath.row]
        cell.mainLabel.text = "Planet: \(planet.name), Moons: \(planet.moons)"
        
        //Color
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.red
        } else {
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }
}

extension PlanetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let planet = viewModel.planets[indexPath.row]
        
        let alertVC = storyboard?.instantiateViewController(identifier: "AlertViewController") as! AlertViewController
        alertVC.planet = planet
    
        present(alertVC, animated: true, completion: nil)
    }
    
}
extension PlanetViewController: ViewModelDelegate {
    func update() {
        DispatchQueue.main.async{
            self.planetTableView.reloadData()
        }
    }
}
