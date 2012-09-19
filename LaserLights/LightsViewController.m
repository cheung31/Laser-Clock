
#import "LightsViewController.h"
#import "LightsView.h"
#import "LaserHand.h"
#import <QuartzCore/QuartzCore.h>

@interface LightsViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) LightsView* lightsView;
@property (strong, nonatomic) UITapGestureRecognizer* tapRec;
@property BOOL rotation;
@end

@implementation LightsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    LightsView* lightsView = [[LightsView alloc] initWithFrame:CGRectMake(0, 0, 768, 768)];
    self.lightsView = lightsView;
    
    CGPoint newCenter = CGPointMake((self.view.bounds.size.width / 2), (self.view.bounds.size.height / 2));
    self.lightsView.center = newCenter;
    [self.lightsView makeClock];
    [self.lightsView updateTime];
    [self.view addSubview:self.lightsView];
    
    self.rotation = NO;
    
    self.tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:self.tapRec];
}

- (void)rotate {
    CABasicAnimation* rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.duration = 0.1;
    rotate.repeatCount = INFINITY;
    rotate.fromValue = [NSNumber numberWithFloat:0];
    rotate.toValue = [NSNumber numberWithFloat:2 * M_PI];
    [self.lightsView.layer addAnimation:rotate forKey:@"Zrotate"];
    
    [self.lightsView.layer addAnimation:rotate forKey:@"Zrotate"];
}

- (void)tap {
    if (self.rotation) {
        [self.lightsView.layer removeAnimationForKey:@"Zrotate"];
        self.rotation = NO;
    } else {
        [self rotate];
        self.rotation = YES;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.lightsView.hidden = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.lightsView.hidden = NO;

    CGRect frame;
    frame.origin = CGPointMake(0, 0);
    frame.size = CGSizeMake(768, 768);
    CGPoint newCenter;
    newCenter = CGPointMake((self.view.bounds.size.width / 2), (self.view.bounds.size.height / 2));
    
    self.lightsView.frame = frame;
    self.lightsView.center = newCenter;
    
}

@end
