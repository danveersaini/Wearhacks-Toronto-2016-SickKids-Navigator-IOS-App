

#import <Foundation/Foundation.h>
@interface BeaconCalculus : NSObject

+ (NSArray *)determinePositionUsingNonLinearLeastSquare:(NSArray *)transmissions;
+ (NSArray *)determinePositionUsingLeastSquare:(NSArray *)transmissions;
+ (NSArray *)curveFitting:(NSDictionary *)values;

@end
