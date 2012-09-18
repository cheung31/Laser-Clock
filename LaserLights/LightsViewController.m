
#import "LightsViewController.h"
#import "LightsView.h"
#import "LaserHand.h"

@interface LightsViewController ()
@property (weak, nonatomic) LightsView* lightsView;
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
}

- (void)viewDidAppear:(BOOL)animated {

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

    //self.lightsView.backgroundColor = [UIColor redColor];
    CGRect frame;
    frame.origin = CGPointMake(0, 0);
    frame.size = CGSizeMake(768, 768);
    CGPoint newCenter;
    newCenter = CGPointMake((self.view.bounds.size.width / 2), (self.view.bounds.size.height / 2));
    
    self.lightsView.frame = frame;
    self.lightsView.center = newCenter;
    
}

@end
