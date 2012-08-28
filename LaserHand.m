
#import "LaserHand.h"
#import <QuartzCore/QuartzCore.h>

@implementation LaserHand
@synthesize layer;
+(LaserHand* ) createLaserHandInCenterOfView:(UIView *)view AndPercentOfScreen:(double)percent {
    float length;
    //set the length equal to smaller bound of the view
    if (view.bounds.size.width > view.bounds.size.height) {
        length = (view.bounds.size.height / 2) * percent;
    } else {
        length = (view.bounds.size.width / 2) * percent;
    }
    //make the hand
    LaserHand* lh = [LaserHand new];
    lh.layer = [CALayer new];
    lh.layer.anchorPoint = CGPointMake(0.5, 1);
    lh.layer.bounds = CGRectMake(0, 0, (400), length);
    lh.layer.backgroundColor = CGColorCreateCopyWithAlpha([[UIColor whiteColor] CGColor], 0);
    lh.layer.position = view.center;
    lh.layer.delegate = lh;
    [lh.layer setNeedsDisplay];
    [view.layer addSublayer:(lh.layer)];
    return lh;
}

//rotate for INFINITY counts
-(void) rotateHandWithTiming:(double)seconds {
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.duration = seconds;
    animation.repeatCount = INFINITY;
    [self.layer addAnimation:animation forKey:@"Zrotation"];
}

@end
