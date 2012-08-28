#import "LightsView.h"
#import "LaserLine.h"
#import "LaserHand.h"
#import <QuartzCore/QuartzCore.h>

@interface LightsView ()
@property LaserLine* secondsLine;
@property LaserHand* secondsHand;
@property double secondsAngle;
@property double secondsTrailSize;
@property NSMutableArray* secondsTrails;
@end
@implementation LightsView
@synthesize secondsLine;
@synthesize secondsHand;
@synthesize secondsAngle;
@synthesize secondsTrailSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.secondsHand = [LaserHand createLaserHandInCenterOfView:self AndPercentOfScreen:0.60];
        [self.secondsHand rotateHandWithTiming:60.0];
        self.secondsTrails = [NSMutableArray new];
        self.secondsAngle = 2*M_PI/60;
        self.secondsTrailSize = 30.5;
        [NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(addSecondsTrail) userInfo:nil repeats:YES];
    }
    return self;
}

//uses a set of properties to generate a dimishing trail of LaserLine sublayers as the LaserHand layer rotates
-(void) addSecondsTrail {
    self.secondsAngle = self.secondsAngle - ((2*M_PI)/60);
    if (self.secondsAngle >= ((-2*M_PI) + 2*M_PI/120)) {
        self.secondsTrailSize = self.secondsTrailSize - 0.5;
    } else {
        self.secondsAngle = 0.0;
        for (int i = 0; i < [self.secondsTrails count]; i++) {
            LaserLine* rml = [self.secondsTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        self.secondsTrails = [NSMutableArray new];
        self.secondsTrailSize = 30.5;
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.secondsAngle InLayer:self.secondsHand.layer WithSize:self.secondsTrailSize];
    [self.secondsTrails addObject:nl]; 
}
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 
*/
//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touchPoint = [touches anyObject];
//    CGPoint point = [touchPoint locationInView:self];
//    [self.testLine moveToPoint:point andDecay:0];
//    [self setNeedsDisplay];
//}
//
//-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touchPoint = [touches anyObject];
//    CGPoint point = [touchPoint locationInView:self];
//    [self.testLine moveToPoint:point andDecay:0];
//    [self setNeedsDisplay];
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touchPoint = [touches anyObject];
//    CGPoint point = [touchPoint locationInView:self];
//    [self.testLine moveToPoint:point andDecay:10];
//    [self setNeedsDisplay];
//}

@end
