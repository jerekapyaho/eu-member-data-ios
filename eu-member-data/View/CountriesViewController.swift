//
//  ViewController.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 21/02/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    @IBOutlet var countriesTable: UITableView!
    
    var viewModel: CountriesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countriesTable.dataSource = self
        countriesTable.rowHeight = 50
        
        viewModel = CountriesViewModel() {
            self.countriesTable.reloadData()
        }
        viewModel?.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTable.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        guard let country = viewModel?.model?[indexPath.row] else {
            fatalError("No such country")
        }
        cell.nameLabel.text = country.name["en"] ?? "Unknown"
        cell.capitalLabel.text = country.capital.name["en"] ?? "Unknown"
        cell.imageView?.image = Flag.of(country.code)
        return cell
    }
}

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var flagImage: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
}
