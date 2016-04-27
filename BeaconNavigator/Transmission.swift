
import CoreLocation

class Transmission : NSObject {
    
    var beacon : CLBeacon
    var timestamp : NSDate
    var distance : CGFloat
    
    required init(beacon : CLBeacon) {
        self.beacon = beacon
        self.timestamp = NSDate()
        self.distance = CGFloat(beacon.getDistance())
    }
}