
#import <Foundation/Foundation.h>

@interface LaserHand : NSObject
@property CALayer* layer;
+(LaserHand* ) createLaserHandInCenterOfView:(UIView* )view AndPercentOfScreen:(double) percent;
-(void) rotateHandWithTiming:(double) seconds;
@end
