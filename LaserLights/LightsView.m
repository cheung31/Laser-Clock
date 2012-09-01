#import "LightsView.h"
#import "LaserLine.h"
#import "LaserHand.h"
#import <QuartzCore/QuartzCore.h>

@interface LightsView ()
//clock elements
@property double halfScreen;
@property (strong, nonatomic) LaserHand* secondsHand;
@property (strong, nonatomic) LaserHand* minutesHand;
@property (strong, nonatomic) LaserHand* hoursHand;
@end

@implementation LightsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //set the general size equal to smaller bound of the view
        if (self.bounds.size.width > self.bounds.size.height) {
            self.halfScreen = (self.bounds.size.height / 2);
        } else {
            self.halfScreen = (self.bounds.size.width / 2);
        }
        //make seconds hand
        self.secondsHand = [LaserHand createLaserHandInCenterOfView:self AndPercentOfScreen:self.halfScreen * 0.55];
        self.secondsHand.lineAngle = 0;
        self.secondsHand.lineSize = self.halfScreen/10;
        self.secondsHand.lineHue = 0.7;
        self.secondsHand.lineBrightness = 1;
        self.secondsHand.lineTrails = [NSMutableArray new];
        //make minutes hand
        self.minutesHand = [LaserHand createLaserHandInCenterOfView:self AndPercentOfScreen:self.halfScreen * 0.85];
        self.minutesHand.lineAngle = 0;
        self.minutesHand.lineSize = self.halfScreen/20;
        self.minutesHand.lineHue = 0.6;
        self.minutesHand.lineBrightness = 1;
        self.minutesHand.lineTrails = [NSMutableArray new];
        //make hours hand
        self.hoursHand = [LaserHand createLaserHandInCenterOfView:self AndPercentOfScreen:self.halfScreen * 0.98];
        self.hoursHand.lineAngle = 0;
        self.hoursHand.lineSize = self.halfScreen/50;
        self.hoursHand.lineHue = 0.5;
        self.hoursHand.lineBrightness = 1;
        self.hoursHand.lineTrails = [NSMutableArray new];
        //synch to current time with milisecond accuracy to system clock
        [self updateTime];      
    }
    return self;
}
-(void) updateTime {
    //get current time
    unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |  NSSecondCalendarUnit;
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *nowComps = [gregorian components:unitFlags fromDate:now];
    double one = 1;
    double milliseconds = modf([now timeIntervalSince1970], &one);
    double seconds = nowComps.second;
    double minutes = nowComps.minute;
    double hours = nowComps.hour;
    
    NSLog(@"milliseconds %f", milliseconds);
    //fast forward to current second
    NSLog(@"seconds %f", seconds);
    double secondsAngle = 0 + (seconds*((2*M_PI)/60));
    for (int i = 0; i < seconds; i++) {
        [self addSecondsTrail];
    }
    [self.secondsHand rotateHandWithTiming:60 FromAngle:secondsAngle];
    NSTimer* secondsSynch = [[NSTimer alloc] initWithFireDate:[now dateByAddingTimeInterval:(milliseconds)] interval:(1) target:self selector:@selector(addSecondsTrail) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:secondsSynch forMode:NSDefaultRunLoopMode];
    
    //fast forward to current minute
    NSLog(@"minutes %f", minutes);
    double minutesAngle = 0 + (minutes*((2*M_PI)/60));
    for (int i = 0; i < minutes; i++) {
        [self addMinutesTrail];
    }
    [self.minutesHand rotateHandWithTiming:3600 FromAngle:minutesAngle];
    NSTimer* minutesSynch = [[NSTimer alloc] initWithFireDate:[now dateByAddingTimeInterval:(seconds)] interval:(60) target:self selector:@selector(addMinutesTrail) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:minutesSynch forMode:NSDefaultRunLoopMode];
    
    //fast forward to current hour
    NSLog(@"hours %f", hours);
    double hoursAngle = 0 + ((hours*(2*M_PI)/24));
    for (int i = 0; i < hours; i++) {
        [self addHoursTrail];
    }
    [self.hoursHand rotateHandWithTiming:86400 FromAngle:hoursAngle];
    NSTimer* hoursSynch = [[NSTimer alloc] initWithFireDate:[now dateByAddingTimeInterval:(minutes * 60)] interval:(3600) target:self selector:@selector(addHoursTrail) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:hoursSynch forMode:NSDefaultRunLoopMode];
}

//trails diminish in size and birghtness as time passes until a cycle has transpired
//seconds
-(void) addSecondsTrail {
    self.secondsHand.lineAngle = self.secondsHand.lineAngle - ((2*M_PI)/60);
    if (self.secondsHand.lineAngle > ((-2*M_PI) + 2*M_PI/120)) {
        self.secondsHand.lineSize  -= self.secondsHand.lineSize/20;
        self.secondsHand.lineBrightness -= 0.01;
    } else {
        for (int i = 0; i < [self.secondsHand.lineTrails count]; i++) {
            LaserLine* rml = [self.secondsHand.lineTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        //reset trails at 12 o'clock position
        self.secondsHand.lineTrails = [NSMutableArray new];
        self.secondsHand.lineAngle = 0.0;
        self.secondsHand.lineSize = self.halfScreen/10;
        self.secondsHand.lineBrightness = 1;
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.secondsHand.lineAngle InLayer:self.secondsHand.layer WithSize:self.secondsHand.lineSize WithHue:self.secondsHand.lineHue WithBrightness:self.secondsHand.lineBrightness];
    [self.secondsHand.lineTrails addObject:nl];
}
//minutes
-(void) addMinutesTrail {
    self.minutesHand.lineAngle = self.minutesHand.lineAngle - ((2*M_PI)/60);
    if (self.minutesHand.lineAngle > ((-2*M_PI) + 2*M_PI/120)) {
        self.minutesHand.lineSize  -= self.minutesHand.lineSize/40;
        self.minutesHand.lineBrightness -= 0.01;
    } else {
        for (int i = 0; i < [self.minutesHand.lineTrails count]; i++) {
            LaserLine* rml = [self.minutesHand.lineTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        //reset trails at 12 o'clock position
        self.minutesHand.lineTrails = [NSMutableArray new];
        self.minutesHand.lineAngle = 0.0;
        self.minutesHand.lineSize = self.halfScreen/20;
        self.minutesHand.lineBrightness = 1;
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.minutesHand.lineAngle InLayer:self.minutesHand.layer WithSize:self.minutesHand.lineSize WithHue:self.minutesHand.lineHue WithBrightness:self.minutesHand.lineBrightness];
    [self.minutesHand.lineTrails addObject:nl];
}
//hours
-(void) addHoursTrail {
    self.hoursHand.lineAngle = self.hoursHand.lineAngle - ((2*M_PI)/24);
    if (self.hoursHand.lineAngle > ((-2*M_PI) + 2*M_PI/120)) {
        self.hoursHand.lineSize  -= self.hoursHand.lineSize/60;
        self.hoursHand.lineBrightness -= 0.01;
    } else {
        for (int i = 0; i < [self.hoursHand.lineTrails count]; i++) {
            LaserLine* rml = [self.hoursHand.lineTrails objectAtIndex:i];
            [rml.layer removeFromSuperlayer];
        }
        //reset trails at 12 o'clock position
        self.hoursHand.lineTrails = [NSMutableArray new];
        self.hoursHand.lineAngle = 0.0;
        self.hoursHand.lineSize = self.halfScreen/50;
        self.hoursHand.lineBrightness = 1;
    }
    LaserLine* nl = [LaserLine createTrailingLineAtAngle:self.hoursHand.lineAngle InLayer:self.hoursHand.layer WithSize:self.hoursHand.lineSize WithHue:self.hoursHand.lineHue WithBrightness:self.hoursHand.lineBrightness];
    [self.hoursHand.lineTrails addObject:nl];
}

@end