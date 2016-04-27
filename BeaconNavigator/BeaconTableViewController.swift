

import UIKit
import CoreLocation
import Foundation

class BeaconTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let CellIdentifier = "BeaconRow"
    
    var locationManager : CLLocationManager?
    
    var beacons : [CLBeacon]?

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell!
        
        let beacon = beacons![indexPath.row]
        
        cell.imageView?.image = UIImage(named: "beacon_blue")
        cell.textLabel?.text = "Major: \(beacon.major) Minor: \(beacon.minor)"
        cell.detailTextLabel?.text = "Accuracy: \(beacon.accuracy) CAccuracy: \(beacon.getAccuracyCalculatedByUsingLogNormal()), RSSI: \(beacon.rssi)"
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didUpdateBeacons:", name: BeaconManagerDidUpdateAvailableBeacons, object: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let beacons = beacons {
            return beacons.count
        }
        return 0
    }
    
    func didUpdateBeacons(notification : NSNotification) {
        let updatedBeacons = notification.userInfo!["beacons"] as! [CLBeacon]
        self.beacons = updatedBeacons
        self.beacons!.sortInPlace { (beacon1, beacon2) in return beacon1.minor.integerValue > beacon2.minor.integerValue }
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let beacon = self.beacons?[indexPath.row]
        let beaconViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("BeaconViewController") as! BeaconViewController
        beaconViewController.beacon = beacon
        self.navigationController?.pushViewController(beaconViewController, animated: true)
    }
}
