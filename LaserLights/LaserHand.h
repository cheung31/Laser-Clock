
#import <Foundation/Foundation.h>

@interface LaserHand : NSObject
@property CALayer* layer;
@property double lineAngle;
@property double lineBounds;
@property double lineSize;
@property double lineHue;
@property double lineBrightness;
@property NSMutableArray* lineTrails;

+(LaserHand* ) createLaserHandInCenterOfView:(UIView* )view WithPortionOfScreen:(double) portion WithLineSize:(double) size WithLineHue:(double) hue;
-(void) addTrailForInterval:(double) interval WithNoonBlock:(void(^)(void))tick;
-(void) rotateHandWithTiming:(double) seconds FromAngle:(double)angle;
@end
