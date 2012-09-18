#import <UIKit/UIKit.h>
@class LaserHand;

@interface LightsView : UIView
-(void)updateTime;
-(void)makeClock;
- (void)reDrawClock;
- (void)setClockCenter:(CGPoint) center;
@end
