
import Foundation

class BeaconMapManager : NSObject {
    
    let mapNames = ["Test","SickKids","Simple"]
    
    static let sharedInstance = BeaconMapManager()
    
    var maps : [BeaconMap] = []
    
    override init() {
        super.init()
        for mapName in mapNames {
            let beaconMap = BeaconMap(fileName: mapName)
            maps.append(beaconMap)
        }
    }
    
    
}