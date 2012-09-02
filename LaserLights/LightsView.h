#import <UIKit/UIKit.h>
@class LaserHand;

@interface LightsView : UIView
//clock elements
@property double halfScreen;
@property (strong, nonatomic) LaserHand* secondsHand;
@property (strong, nonatomic) LaserHand* minutesHand;
@property (strong, nonatomic) LaserHand* hoursHand;
-(void) updateTime;
-(void) makeClock;
@end
