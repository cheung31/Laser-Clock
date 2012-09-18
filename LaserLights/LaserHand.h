
#import <Foundation/Foundation.h>

@interface LaserHand : NSObject
@property CALayer* layer;
@property NSMutableArray* lineTrails;

+ (LaserHand*) createLaserHandInCenterOfView:(UIView*)view WithPortionOfScreen:(double) portion WithLineSize:(double) size WithLineHue:(double) hue;
- (void) addTrailForInterval:(double) interval WithNoonBlock:(void(^)(void))tick;
- (void) rotateHandWithTiming:(double) seconds FromAngle:(double)angle;
@end
