
#import "LaserHand.h"
#import <QuartzCore/QuartzCore.h>

@implementation LaserHand
@synthesize layer;
+(LaserHand* ) createLaserHandInCenterOfView:(UIView *)view AndPercentOfScreen:(double)percent {
    //make the hand
    LaserHand* lh = [LaserHand new];
    lh.layer = [CALayer new];
    lh.layer.anchorPoint = CGPointMake(0.5, 1);
    lh.layer.bounds = CGRectMake(0, 0, (400), percent);
    lh.layer.backgroundColor = CGColorCreateCopyWithAlpha([[UIColor whiteColor] CGColor], 0);
    lh.layer.position = view.center;
    lh.layer.delegate = lh;
    [lh.layer setNeedsDisplay];
    [view.layer addSublayer:(lh.layer)];
    return lh;
}

//rotate for INFINITY counts
-(void) rotateHandWithTiming:(double)seconds FromAngle:(double)angle {
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:angle];
    animation.toValue = [NSNumber numberWithFloat: angle + 2*M_PI];
    animation.duration = seconds;
    animation.repeatCount = INFINITY;
    [self.layer addAnimation:animation forKey:@"Zrotation"];
}

@end
