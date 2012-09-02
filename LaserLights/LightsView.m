#import "LightsView.h"
#import "LaserLine.h"
#import "LaserHand.h"
#import <QuartzCore/QuartzCore.h>

@interface LightsView ()
@end

@implementation LightsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeClock];
    }
    return self;
}

-(void)makeClock {
    if (self.bounds.size.width > self.bounds.size.height) {
        self.halfScreen = (self.bounds.size.height / 2);
    } else {
        self.halfScreen = (self.bounds.size.width / 2);
    }
    //make seconds hand
    self.secondsHand = [LaserHand createLaserHandInCenterOfView:self
                                            WithPortionOfScreen:self.halfScreen * 0.6
                                                   WithLineSize:self.halfScreen/10
                                                    WithLineHue:0.7];
    //make minutes hand
    self.minutesHand = [LaserHand createLaserHandInCenterOfView:self
                                            WithPortionOfScreen:self.halfScreen * 0.88
                                                   WithLineSize:self.halfScreen/20
                                                    WithLineHue:0.6];
    //make hours hand
    self.hoursHand = [LaserHand createLaserHandInCenterOfView:self
                                          WithPortionOfScreen:self.halfScreen
                                                 WithLineSize:self.halfScreen/50
                                                  WithLineHue:0.5];
}

-(void)updateTime {
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
        [self.secondsHand addTrailForInterval:(60) WithNoonBlock:nil];
    }
    [self.secondsHand rotateHandWithTiming:60 FromAngle:secondsAngle];
    NSTimer* secondsSynch = [[NSTimer alloc] initWithFireDate:[now dateByAddingTimeInterval:(milliseconds)] interval:(1) target:self selector:@selector(addTrail) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:secondsSynch forMode:NSDefaultRunLoopMode];
    
    //fast forward to current minute
    NSLog(@"minutes %f", minutes);
    double minutesSynch = minutes + ((seconds + milliseconds) / 60);
    double minutesAngle = 0 + (minutesSynch * ((2*M_PI)/60));
    for (int i = 0; i < minutes; i++) {
        [self.minutesHand addTrailForInterval:(60) WithNoonBlock:nil];
    }
    [self.minutesHand rotateHandWithTiming:3600 FromAngle:minutesAngle];
    
    //fast forward to current hour
    NSLog(@"hours %f", hours);
    double hoursSynch = hours + (minutesSynch / 60);
    double hoursAngle = 0 + ((hoursSynch*(2*M_PI)/24));
    for (int i = 0; i < hours; i++) {
        [self.hoursHand addTrailForInterval:(24) WithNoonBlock:nil];
    }
    [self.hoursHand rotateHandWithTiming:86400 FromAngle:hoursAngle];
}

//synch with other hands
-(void) addTrail {
    [self.secondsHand addTrailForInterval:(60) WithNoonBlock:^{
        [self.minutesHand addTrailForInterval:(60) WithNoonBlock:^{
            [self.hoursHand addTrailForInterval:(24) WithNoonBlock:^{
                //a brand new day!!!
            }];
        }];
    }];
}
@end