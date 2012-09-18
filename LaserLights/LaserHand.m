
#import "LaserHand.h"
#import "LaserLine.h"
#import <QuartzCore/QuartzCore.h>

@interface LaserHand ()
@property double lineAngle;
@property double lineBounds;
@property double lineSize;
@property double lineHue;
@property double lineBrightness;
@end

@implementation LaserHand

+ (LaserHand*)createLaserHandInCenterOfView:(UIView *)view WithPortionOfScreen:(double)portion WithLineSize:(double)size WithLineHue:(double)hue {
    //make the hand
    LaserHand* lh = [LaserHand new];
    lh.layer = [CALayer new];
    lh.layer.anchorPoint = CGPointMake(0.5, 1);
    lh.layer.bounds = CGRectMake(0, 0, 0, portion);
    lh.layer.backgroundColor = CGColorCreateCopyWithAlpha([[UIColor whiteColor] CGColor], 0);
    lh.layer.position = CGPointMake(view.frame.size.width / 2.,view.frame.size.height / 2.);
    lh.layer.delegate = lh;
    lh.lineAngle = 0;
    lh.lineTrails =[NSMutableArray new];
    lh.lineBrightness = 1;
    //configure unique properties
    lh.lineHue = hue;
    lh.lineBounds = size;
    lh.lineSize = size;
    //add to superlayer
    [lh.layer setNeedsDisplay];
    [view.layer addSublayer:lh.layer];
    return lh;
}

- (void)addTrailForInterval:(double)interval WithNoonBlock:(void (^)(void))tick {
    self.lineAngle = self.lineAngle - ((2 * M_PI)/interval);
    if (self.lineAngle > ((-2 * M_PI) + 2 * M_PI/120)) {
        self.lineSize -= self.lineBounds/interval;
        self.lineBrightness -= 0.01;
    } else {
        for (int i = 0; i < [self.lineTrails count]; i++) {
            LaserLine* rml = [self.lineTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        //reset trails at 12 o'clock position
        self.lineTrails = [NSMutableArray new];
        self.lineAngle = 0.0;
        self.lineSize = self.lineBounds;
        self.lineBrightness = 1;
        //send the time up the chain
        tick();
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.lineAngle InLayer:self.layer WithSize:self.lineSize WithHue:self.lineHue WithBrightness:self.lineBrightness];
    [self.lineTrails addObject:nl];
}

//rotate for INFINITY counts
- (void)rotateHandWithTiming:(double)seconds FromAngle:(double)angle {
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:angle];
    animation.toValue = [NSNumber numberWithFloat: angle + 2*M_PI];
    animation.duration = seconds;
    animation.repeatCount = INFINITY;
    [self.layer addAnimation:animation forKey:@"Zrotation"];
}

@end
