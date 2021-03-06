

import CoreLocation
import Accelerate

let BeaconManagerDidUpdateAvailableBeacons = "beaconManagerDidUpdateAvailableBeacons"

class BeaconManager : NSObject, CLLocationManagerDelegate {
    
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
    
    static let sharedInstance = BeaconManager()
    
    let locationManager = CLLocationManager()
    
    var currentAvailableBeacons : [CLBeacon] = []
    var allKnownBeacons : [CLBeacon] = []
    
    override init() {
        super.init()
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.startRangingBeaconsInRegion(region)
        locationManager.startMonitoringForRegion(region)
        region.notifyEntryStateOnDisplay = true
        
        locationManager.delegate = self
    }
    
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        currentAvailableBeacons = beacons 
        allKnownBeacons += beacons 

        NSNotificationCenter.defaultCenter().postNotificationName(BeaconManagerDidUpdateAvailableBeacons, object: nil, userInfo: ["beacons":beacons])
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
    }
    
}