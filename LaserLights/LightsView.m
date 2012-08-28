#import "LightsView.h"
#import "LaserLine.h"
#import "LaserHand.h"
#import <QuartzCore/QuartzCore.h>

@interface LightsView ()
//seconds properties
@property LaserLine* secondsLine;
@property LaserHand* secondsHand;
@property double secondsAngle;
@property double secondsSize;
@property double secondsHue;
@property double secondsBrightness;
@property NSMutableArray* secondsTrails;
//minutes properties
@property LaserLine* minutesLine;
@property LaserHand* minutesHand;
@property double minutesAngle;
@property double minutesSize;
@property double minutesHue;
@property double minutesBrightness;
@property NSMutableArray* minutesTrails;
//hours properties
@property LaserLine* hoursLine;
@property LaserHand* hoursHand;
@property double hoursAngle;
@property double hoursSize;
@property double hoursHue;
@property double hoursBrightness;
@property NSMutableArray* hoursTrails;
@end
@implementation LightsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //make seconds hand
        self.secondsHand = [LaserHand createLaserHandInCenterOfView:self AndPercentOfScreen:0.65];
        [self.secondsHand rotateHandWithTiming:60.0];
        self.secondsTrails = [NSMutableArray new];
        self.secondsAngle = 0;
        self.secondsSize = 30.5;
        self.secondsHue = 0.7;
        self.secondsBrightness = 1;
        LaserLine* nsl = [LaserLine createTrailingLineAtAngle:self.secondsAngle InLayer:self.secondsHand.layer WithSize:self.secondsSize WithHue:self.secondsHue WithBrightness:self.secondsBrightness];
        [self.secondsTrails addObject:nsl];
        [NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(addSecondsTrail) userInfo:nil repeats:YES];
        //make minutes hand
        self.minutesHand = [LaserHand createLaserHandInCenterOfView:self AndPercentOfScreen:0.88];
        [self.minutesHand rotateHandWithTiming:3600.0];
        self.minutesTrails = [NSMutableArray new];
        self.minutesAngle = 0;
        self.minutesSize = 15.5;
        self.minutesHue = 0.6;
        self.minutesBrightness = 1;
        LaserLine* nml = [LaserLine createTrailingLineAtAngle:self.minutesAngle InLayer:self.minutesHand.layer WithSize:self.minutesSize WithHue:self.minutesHue WithBrightness:self.minutesBrightness];
        [self.minutesTrails addObject:nml];
        [NSTimer scheduledTimerWithTimeInterval:(60) target:self selector:@selector(addMinutesTrail) userInfo:nil repeats:YES];
        //make hours hand
        self.hoursHand = [LaserHand createLaserHandInCenterOfView:self AndPercentOfScreen:0.98];
        [self.hoursHand rotateHandWithTiming:86400.0];
        self.hoursTrails = [NSMutableArray new];
        self.hoursAngle = 0;
        self.hoursSize = 5.5;
        self.hoursHue = 0.5;
        self.hoursBrightness = 1;
        LaserLine* nhl = [LaserLine createTrailingLineAtAngle:self.hoursAngle InLayer:self.hoursHand.layer WithSize:self.hoursSize WithHue:self.hoursHue WithBrightness:self.hoursBrightness];
        [self.hoursTrails addObject:nhl];
        [NSTimer scheduledTimerWithTimeInterval:(3600) target:self selector:@selector(addHoursTrail) userInfo:nil repeats:YES];
        
    }
    return self;
}

//trails use a set of properties to generate a dimishing trail of LaserLine sublayers as the LaserHand layer rotates

//seconds
-(void) addSecondsTrail {
    self.secondsAngle = self.secondsAngle - ((2*M_PI)/60);
    if (self.secondsAngle > ((-2*M_PI) + 2*M_PI/120)) {
        self.secondsSize  -= 0.5;
        self.secondsBrightness -= 0.01;
    } else {
        for (int i = 0; i < [self.secondsTrails count]; i++) {
            LaserLine* rml = [self.secondsTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        //reset trails at 12 o'clock position
        self.secondsTrails = [NSMutableArray new];
        self.secondsAngle = 0.0;
        self.secondsSize = 30.5;
        self.secondsBrightness = 1;
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.secondsAngle InLayer:self.secondsHand.layer WithSize:self.secondsSize WithHue:self.secondsHue WithBrightness:self.secondsBrightness];
    [self.secondsTrails addObject:nl];
}
//minutes
-(void) addMinutesTrail {
    self.minutesAngle = self.minutesAngle - ((2*M_PI)/60);
    if (self.minutesAngle > ((-2*M_PI) + 2*M_PI/120)) {
        self.minutesSize  -= 0.25;
        self.minutesBrightness -= 0.01;
    } else {
        for (int i = 0; i < [self.minutesTrails count]; i++) {
            LaserLine* rml = [self.minutesTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        //reset trails at 12 o'clock position
        self.minutesTrails = [NSMutableArray new];
        self.minutesAngle = 0.0;
        self.minutesSize = 15.5;
        self.minutesBrightness = 1;
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.minutesAngle InLayer:self.minutesHand.layer WithSize:self.minutesSize WithHue:self.minutesHue WithBrightness:self.minutesBrightness];
    [self.minutesTrails addObject:nl];
}
//hours
-(void) addHoursTrail {
    self.hoursAngle = self.hoursAngle - ((2*M_PI)/60);
    if (self.hoursAngle > ((-2*M_PI) + 2*M_PI/120)) {
        self.hoursSize  -= 0.1;
        self.hoursBrightness -= 0.01;
    } else {
        for (int i = 0; i < [self.hoursTrails count]; i++) {
            LaserLine* rml = [self.hoursTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        //reset trails at 12 o'clock position
        self.hoursTrails = [NSMutableArray new];
        self.hoursAngle = 0.0;
        self.hoursSize = 1.5;
        self.hoursBrightness = 1;
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.hoursAngle InLayer:self.hoursHand.layer WithSize:self.hoursSize WithHue:self.hoursHue WithBrightness:self.hoursBrightness];
    [self.hoursTrails addObject:nl];
}
@end