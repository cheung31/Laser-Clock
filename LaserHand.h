
#import <Foundation/Foundation.h>

@interface LaserHand : NSObject
@property CALayer* layer;
@property double lineAngle;
@property double lineSize;
@property double lineHue;
@property double lineBrightness;
@property NSMutableArray* lineTrails;

+(LaserHand* ) createLaserHandInCenterOfView:(UIView* )view AndPercentOfScreen:(double) percent;
-(void) rotateHandWithTiming:(double) seconds FromAngle:(double)angle;
@end
