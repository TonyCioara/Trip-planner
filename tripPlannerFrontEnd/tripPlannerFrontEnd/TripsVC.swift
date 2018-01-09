//
//  TripsVC.swift
//  tripPlannerFrontEnd
//
//  Created by Tony Cioara on 1/7/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class TripsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: User!
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var trip: [String]
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell") as! TripsTableViewCell
        trip = user.trips[indexPath.row]
        cell.destinationLabel.text = trip[1]
        cell.dateLabel.text = trip[2]
        if trip[3] == "True" {
            cell.completedSwitch.isOn = true
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
